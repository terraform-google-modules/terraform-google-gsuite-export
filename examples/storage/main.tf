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

module "gsuite-log-export" {
  source  = "github.com/terraform-google-modules/terraform-google-log-export"
  filter  = module.gsuite-export.filter
  destination_uri        = module.destination.destination_uri
  log_sink_name          = "storage_project_${random_string.suffix.result}"
  parent_resource_id     = var.project_id
  parent_resource_type   = "project"
  unique_writer_identity = "true"
}


module "destination" {
  source                   = "github.com/terraform-google-modules/terraform-google-log-export/modules/storage"
  project_id               = var.project_id
  storage_bucket_name      = "storage_project_${random_string.suffix.result}"
  log_sink_writer_identity = module.gsuite-log-export.writer_identity
}