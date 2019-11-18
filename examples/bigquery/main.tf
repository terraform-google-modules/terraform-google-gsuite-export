/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  version = "~> 2.15.0"
}

locals {
  bigquery = {
    name    = "my-bigquery"
    project = var.project_id
  }
}

resource "google_compute_network" "default" {
  name                    = "example-network"
  auto_create_subnetworks = "false"
}

module "gsuite-export" {
  source          = "../../"
  service_account = var.service_account
  api             = "reports_v1"
  applications    = ["login", "drive", "token"]
  admin_user      = "superadmin@domain.com"
  project_id      = var.project_id
  machine_name    = "gsuite-exporter-bq"
  machine_network = google_compute_network.default.self_link
}

module "gsuite-log-export" {
  source                 = "terraform-google-modules/log-export/google"
  version                = "~> 3.0.0"
  destination_uri        = module.bigquery.destination_uri
  filter                 = module.gsuite-export.filter
  log_sink_name          = "gsuite_export_bq"
  parent_resource_id     = var.project_id
  parent_resource_type   = "project"
  unique_writer_identity = local.bigquery.project == var.project_id ? "false" : "true"
}

module "bigquery" {
  source                   = "terraform-google-modules/log-export/google//modules/bigquery"
  version                  = "~> 3.0.0"
  project_id               = local.bigquery.project
  dataset_name             = local.bigquery.name
  log_sink_writer_identity = module.gsuite-log-export.writer_identity
}
