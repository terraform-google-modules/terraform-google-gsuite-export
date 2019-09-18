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

output "filter" {
  value = local.export_filter
}

output "instance_name" {
  value = var.machine_name
}

output "instance_zone" {
  value = var.machine_zone
}

output "instance_project" {
  value = local.machine_project
}

output "instance_ssh_command" {
  value = "gcloud beta compute ssh ${var.machine_name} --zone=${var.machine_zone} --project=${local.machine_project}"
}
