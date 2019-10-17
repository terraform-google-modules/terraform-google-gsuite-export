/**
 * Copyright 2018 Google LLC
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
  version                = "~> 3.0.0"
  destination_uri        = module.pubsub.destination_uri
  filter                 = module.gsuite-export.filter
  log_sink_name          = var.export_name
  parent_resource_id     = var.project_id
  parent_resource_type   = "project"
  unique_writer_identity = var.pubsub.project == var.project_id ? "false" : "true"
}

module "pubsub" {
  source                   = "terraform-google-modules/log-export/google//modules/pubsub"
  version                  = "~> 3.0.0"
  project_id               = var.pubsub.project
  topic_name               = var.pubsub.name
  log_sink_writer_identity = module.gsuite-log-export.writer_identity
  create_subscriber        = "false"
}
