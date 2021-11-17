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

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "example-vpc-module" {
  source                  = "terraform-google-modules/network/google"
  version                 = "~> 3.0"
  project_id              = var.project_id
  network_name            = "vpc-network-${random_string.suffix.result}"
  auto_create_subnetworks = true
  subnets                 = []
}

module "gsuite_export" {
  source          = "../../"
  service_account = var.service_account
  api             = "reports_v1"
  applications    = ["login", "drive", "token"]
  admin_user      = "superadmin@domain.com"
  project_id      = var.project_id
  machine_name    = "gsuite-exporter-simple"
  machine_network = module.example-vpc-module.network_name
}
