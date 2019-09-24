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

variable "admin_user" {
  description = "The GSuite Admin user to impersonate"
}

variable "api" {
  description = "The Admin SDK API to sync data from"
  default     = "reports_v1"
}

variable "applications" {
  description = "The Admin SDK applications to sync data from (space-separated)"
  default     = "admin login drive mobile token"
}

variable "service_account" {
  description = "The service account for exporting GSuite data. Needs domain-wide delegation and correct access scopes."
}

variable "project_id" {
  description = "The project to export GSuite data to."
}

variable "machine_name_pubsub" {
  description = "Compute Engine instance name (PubSub)"
}

variable "machine_name_bigquery" {
  description = "Compute Engine instance name (BigQuery)"
}

variable "machine_name_storage" {
  description = "Compute Engine instance name (Storage)"
}

variable "machine_name_stackdriver" {
  description = "Compute Engine instance name (Stackdriver)"
}

variable "export_name_pubsub" {
  description = "PubSub log export name"
}

variable "export_name_bigquery" {
  description = "BigQuery log export name"
}

variable "export_name_storage" {
  description = "Storage log export name"
}

variable "bigquery" {
  description = "BigQuery log export configuration"
  type = object({
    project = string
    name    = string
  })
}

variable "pubsub" {
  description = "PubSub log export configuration"
  type = object({
    project = string
    name    = string
  })
}

variable "storage" {
  description = "Storage log export configuration"
  type = object({
    project = string
    name    = string
  })
}
