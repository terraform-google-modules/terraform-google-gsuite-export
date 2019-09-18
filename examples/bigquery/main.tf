provider "google" {
  credentials = file(var.credentials_path)
}

module "gsuite-export" {
  source          = "../../"
  service_account = var.service_account
  api             = var.api
  applications    = var.applications
  admin_user      = var.admin_user
  project_id      = var.project_id
  machine_name    = var.machine_name
}

module "gsuite-log-export" {
  source                 = "terraform-google-modules/log-export/google"
  destination_uri        = module.bigquery.destination_uri
  filter                 = module.gsuite-export.filter
  log_sink_name          = var.export_name
  parent_resource_id     = var.project_id
  parent_resource_type   = "project"
  unique_writer_identity = var.bigquery.project == var.project_id ? "false" : "true"
}

module "bigquery" {
  source                   = "terraform-google-modules/log-export/google//modules/bigquery"
  project_id               = var.bigquery.project
  dataset_name             = var.bigquery.name
  log_sink_writer_identity = module.gsuite-log-export.writer_identity
}
