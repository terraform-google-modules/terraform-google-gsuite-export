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

#------------------------#
# GSuite export settings #
#------------------------#
variable "admin_user" {
  description = "The GSuite Admin user to impersonate"
}

variable "api" {
  description = "The Admin SDK API to sync data from"
  default     = "reports_v1"
}

variable "applications" {
  description = "The Admin SDK applications to sync data from"
  type        = list(string)
  default     = ["admin", "login", "drive", "mobile", "token"]
}

variable "frequency" {
  description = "The crontab entry that controls the sync frequency"
  default     = "*/10 * * * *"
}

variable "service_account" {
  description = "The service account for exporting GSuite data. Needs domain-wide delegation and correct access scopes."
}

variable "project_id" {
  type        = "string"
  description = "The project to export GSuite data to."
}

variable "export_filter" {
  description = "The export filter to use in a log export (if any)"
  default     = ""
}

variable "gsuite_exporter_version" {
  description = "Version of the gsuite-exporter PyPi package"
  default     = "0.0.3" # latest version
}

#---------------------------#
# VM exporter configuration #
#---------------------------#
variable "machine_zone" {
  description = "The instance zone"
  default     = "us-central1-a"
}

variable "machine_project" {
  description = "The instance project id. Defaults to `project_id`"
  default     = ""
}

variable "machine_type" {
  description = "The instance type"
  default     = "f1-micro"
}

variable "machine_name" {
  description = "The instance name"
  default     = "gsuite-exporter"
}

variable "machine_image" {
  description = "The instance image"
  default     = "debian-cloud/debian-9"
}

variable "machine_network" {
  description = "The instance network"
  default     = "default"
}
