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

output "filter" {
  value       = local.export_filter
  description = "Log export filter for logs exported by GSuite-exporter"
}

output "instance_name" {
  value       = google_compute_instance.gsuite_exporter_vm.name
  description = "GSuite Exporter instance name"
}

output "instance_zone" {
  value       = google_compute_instance.gsuite_exporter_vm.zone
  description = "GSuite Exporter instance zone"
}

output "instance_project" {
  value       = local.machine_project
  description = "GSuite Exporter instance project"
}

output "instance_ssh_command" {
  value       = "gcloud beta compute ssh ${google_compute_instance.gsuite_exporter_vm.name} --zone=${google_compute_instance.gsuite_exporter_vm.zone} --project=${local.machine_project}"
  description = "GSuite Exporter instance SSH command"
}
