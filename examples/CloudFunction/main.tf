provider "google-beta" {
  project     = var.project_id
  region      = var.region
  version     = "~> 2.0"
}

provider "archive" {
  version = "1.2"
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/gsuite-exporter-cloudfunction"
  output_path = "${path.module}/gsuite-exporter.zip"
}

resource "google_project_service" "required-project-services" {
  count = length(var.enabled_services)
  project = var.project_id
  service = element(var.enabled_services, count.index)
  disable_on_destroy  = false
}

resource "google_storage_bucket" "bucket" {
  depends_on = ["google_project_service.required-project-services"]
  project = var.project_id
  name    = "${var.name}-gsuite-exporter"
}

resource "google_storage_bucket_object" "archive" {
  name   = "gsuite-exporter.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.source.output_path
}

resource "google_cloudfunctions_function" "function" {
  name                  = "${var.name}-gsuite-exporter" 
  region                = var.region
  project               = var.project_id
  description           = "Cloudfunction which pulls Gsuite Logs into Stackdriver"
  runtime               = "python37"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  timeout               = 60
  service_account_email = var.gsuite_exporter_service_account
  entry_point           = "run"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource = google_pubsub_topic.trigger-topic.name
  }
}

resource "google_pubsub_topic" "trigger-topic" {
  project = var.project_id
  name    = "gsuite-admin-logs-topic-trigger"
}

// Cloud Scheduler Requires App Engine Application to be deployed in Project. See https://cloud.google.com/scheduler/docs/
resource "google_app_engine_application" "app" {
  count       = var.enable_app_engine ? 1 : 0 
  project     = var.project_id
  location_id = "us-central"
}

resource "google_cloud_scheduler_job" "job" {
  depends_on = ["google_app_engine_application.app"]
  provider = "google-beta"
  project  = var.project_id
  region   = var.region
  name     = "${var.name}-gsuite-audit-log-scheduler"
  description = "Scheduler for Gsuite Exporter Cloudfunction"
  schedule = var.cs_schedule
  time_zone = "America/Denver"

  pubsub_target {
    topic_name = "projects/${var.project_id}/topics/${google_pubsub_topic.trigger-topic.name}"
    data = base64encode("{\"PROJECT_ID\":\"${var.project_id}\",\"GSUITE_ADMIN_USER\":\"${var.gsuite_admin_user}\"}")
  }
}
