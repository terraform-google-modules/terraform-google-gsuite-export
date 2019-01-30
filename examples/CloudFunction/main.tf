
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/gsuite-exporter-cloudfunction"
  output_path = "${path.module}/gsuite-exporter.zip"
}

//ToDO: Add Required Services

resource "google_storage_bucket" "bucket" {
  project = "${var.project_id}"
  name    = "${var.name}-gsuite-exporter"
}

resource "google_storage_bucket_object" "archive" {
  name       = "gsuite-exporter.zip"
  bucket     = "${google_storage_bucket.bucket.name}"
  source     = "${data.archive_file.source.output_path}"
}

//Work Around due to non-supported features of cloudfunctions

resource "null_resource" "function-sa" {
  depends_on = ["google_storage_bucket_object.archive"]
  provisioner "local-exec" {
    when = "create"
    command = "gcloud beta functions deploy ${var.name}-gsuite-exporter --runtime python37 --source=gs://${google_storage_bucket.bucket.name}/${google_storage_bucket_object.archive.name} --stage-bucket=${google_storage_bucket.bucket.name} --service-account=${var.gsuite_exporter_service_account} --entry-point=run --memory=128MB --timeout=60 --trigger-topic=${google_pubsub_topic.trigger-topic.name} --set-env-vars=PROJECT_ID=${var.project_id},GSUITE_ADMIN_USER=${var.gsuite_admin_user} --region=${var.region} --project=${var.project_id}"
  }

  provisioner "local-exec" {
      when = "destroy"
      command = "gcloud beta functions delete ${var.name}-gsuite-exporter --region=${var.region}"
  }
}

resource "google_pubsub_topic" "trigger-topic" {
  project = "${var.project_id}"
  name    = "gsuite-admin-logs-topic-trigger"
}

// Work Around to create a cloud scheduler as this is not a supporter resources in terraform currently
resource "null_resource" "cloud-scheduler" {
  provisioner "local-exec" {
    when = "create"
    command = "gcloud beta scheduler jobs create pubsub gsuite-audit-log-scheduler --schedule=\"${var.cs_schedule}\" --topic=${google_pubsub_topic.trigger-topic.name} --message-body='{\"PROJECT_ID\":\"${var.project_id}\",\"GSUITE_ADMIN_USER\":\"${var.gsuite_admin_user}\"}' --project=${var.project_id}" 
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "gcloud beta scheduler jobs delete gsuite-audit-log-scheduler --project=${var.project_id} --quiet"
  }
}