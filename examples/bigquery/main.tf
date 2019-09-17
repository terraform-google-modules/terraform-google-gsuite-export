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

resource "random_string" "suffix" {
  length  = 4
  upper   = "false"
  special = "false"
}

module "log_export" {
  source                 = "github.com/terraform-google-modules/terraform-google-log-export"
  destination_uri        = module.destination.destination_uri
  filter                 = module.gsuite-export.filter
  log_sink_name          = "bigquery_project_${random_string.suffix.result}"
  parent_resource_id     = var.project_id
  parent_resource_type   = "project"
  unique_writer_identity = "true"
}

module "destination" {
  source                   = "github.com/terraform-google-modules/terraform-google-log-export/modules/bigquery"
  project_id               = var.project_id
  dataset_name             = "bq_project_${random_string.suffix.result}"
  log_sink_writer_identity = module.log_export.writer_identity
}
