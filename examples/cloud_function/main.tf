/**
 * Copyright 2021-2024 Google LLC
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

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Template for requirements.txt file
data "template_file" "requirements_txt_tpl" {
  template = file("${path.module}/requirements.tpl")
  vars = {
    version = var.gsuite_exporter_version
  }
}

// Create requirements.txt file from template
resource "local_file" "requirements_txt" {
  content  = data.template_file.requirements_txt_tpl.rendered
  filename = "${path.module}/code/requirements.txt"
}

// Enable required services for the Project
resource "google_project_service" "required-project-services" {
  depends_on         = [local_file.requirements_txt]
  count              = length(var.enabled_services)
  project            = var.project_id
  service            = element(var.enabled_services, count.index)
  disable_on_destroy = false
}

// Cloud Scheduler Requires App Engine Application to be deployed in Project. See https://cloud.google.com/scheduler/docs/
resource "google_app_engine_application" "app" {
  count       = var.enable_app_engine ? 1 : 0
  project     = var.project_id
  location_id = "us-central"
}

// Create the Pub/Sub, CFN, and Scheduler using Module
module "pubsub_scheduled_example" {
  source                         = "terraform-google-modules/scheduled-function/google"
  version                        = "~> 8.0"
  project_id                     = google_project_service.required-project-services[0].project
  job_name                       = "${var.name}-gsuite-audit-log-scheduler"
  job_schedule                   = var.cs_schedule
  job_description                = "Scheduler for Gsuite Exporter Cloudfunction"
  time_zone                      = "America/Denver"
  function_entry_point           = "run"
  function_source_directory      = "${path.module}/code"
  function_name                  = "${var.name}-gsuite-exporter"
  function_timeout_s             = 60
  function_available_memory_mb   = 128
  region                         = var.region
  topic_name                     = "gsuite-admin-logs-topic-trigger"
  function_runtime               = "python37"
  function_description           = "Cloudfunction which pulls Gsuite Logs into Stackdriver"
  bucket_name                    = "${var.name}-gsuite-exporter"
  function_service_account_email = var.gsuite_exporter_service_account
  message_data                   = base64encode("{\"PROJECT_ID\":\"${var.project_id}\",\"GSUITE_ADMIN_USER\":\"${var.gsuite_admin_user}\"}")
}
