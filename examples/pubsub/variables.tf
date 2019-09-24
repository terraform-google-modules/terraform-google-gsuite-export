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

variable "credentials_path" {
  description = "Credentials path"
}

variable "admin_user" {
  description = "The GSuite Admin user to impersonate"
}

variable "api" {
  description = "The Admin SDK API to sync data from"
}

variable "applications" {
  description = "The Admin SDK applications to sync data from (space-separated)"
}

variable "service_account" {
  description = "The service account for exporting GSuite data. Needs domain-wide delegation and correct access scopes."
}

variable "project_id" {
  description = "The project to export GSuite data to."
}

variable "machine_name" {
  description = "Compute Engine instance name"
}

variable "export_name" {
  description = "PubSub log export name"
}

variable "pubsub" {
  description = "PubSub log export configuration"
  type = map(object({
    project = string
    name    = string
  }))
}
