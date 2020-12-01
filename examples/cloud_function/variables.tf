/**
 * Copyright 2020 Google LLC
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

## Required Variables

variable "project_id" {
  description = "The Project ID to provision resources into"
}

variable "gsuite_admin_user" {
  description = "The GSuite Admin user to impersonate"
}

variable "gsuite_exporter_service_account" {
  description = "The service account for exporting GSuite data. Needs domain-wide delegation and correct access scopes."
}

## Optional Variables

variable "region" {
  description = "The Region to deploy the cloudfunction.  Currently this is only available in us-central-1"
  default     = "us-east1"
}

variable "name" {
  description = "The Prefix for resource names"
  default     = "demo-cf-export"
}

variable "cs_schedule" {
  description = "The Schedule which to trigger the function"
  default     = "*/10 * * * *"
}

variable "enabled_services" {
  description = "The Google Services required to be enabled on the project to deploy and run the cloudfunction"
  type        = list(string)
  default = [
    "storage-component.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudscheduler.googleapis.com",
    "pubsub.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com"
  ]
}

variable "enable_app_engine" {
  description = "Boolean Variable to create App Engine App.  This is required for cloudscheduler.  If an App Engine App already exists in your project, set to false.  Otherwise set to true"
  default     = true
}

variable "gsuite_exporter_version" {
  description = "The version of the gsuite exporter pypi project"
  default     = "0.0.3"
}
