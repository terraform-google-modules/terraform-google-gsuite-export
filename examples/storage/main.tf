provider "google" {
  credentials = "${file(var.credentials_path)}"
}

module "gsuite-export" {
  source          = "../../"
  service_account = "${var.service_account}"
  api             = "${var.api}"
  applications    = "${var.applications}"
  admin_user      = "${var.admin_user}"
  project_id      = "${var.project_id}"
  machine_name    = "${var.machine_name}"
}

module "gsuite-log-export" {
  source  = "github.com/terraform-google-modules/terraform-google-log-export"
  name    = "${var.export_name}"
  project = "${var.project_id}"
  filter  = "${module.gsuite-export.filter}"
  storage = "${var.storage}"
}
