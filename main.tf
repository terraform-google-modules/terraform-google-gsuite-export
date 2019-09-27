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

locals {
  export_filter   = "${var.export_filter != "" ? var.export_filter : data.external.compute_filter.result.filter}"
  machine_project = "${var.machine_project != "" ? var.machine_project : var.project_id}"
}

#------#
# Data #
#------#
data "external" "compute_filter" {
  program = [
    "python",
    "${path.module}/scripts/get_logsink_filter.py",
    "${var.project_id}",
    "${var.applications}",
  ]
}

data "template_file" "gsuite_exporter" {
  template = "${file("${path.module}/scripts/gsuite_exporter.sh.tpl")}"

  vars {
    admin_user   = "${var.admin_user}"
    api          = "${var.api}"
    applications = "${var.applications}"
    project_id   = "${var.project_id}"
    frequency    = "${var.frequency}"
  }
}

#--------------------#
# GSuite Exporter VM #
#--------------------#
resource "google_compute_instance" "gsuite_exporter_vm" {
  name                      = "${var.machine_name}"
  machine_type              = "${var.machine_type}"
  zone                      = "${var.machine_zone}"
  project                   = "${local.machine_project}"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${var.machine_image}"
    }
  }

  network_interface {
    network       = "${var.machine_network}"
    access_config = {}
  }

  metadata_startup_script = "${data.template_file.gsuite_exporter.rendered}"

  vm_service_account {
    email  = "${var.vm_service_account}"
    scopes = ["cloud-platform"]
  }
}

#---------------------------#
# Service account IAM roles #
#---------------------------#
resource "google_project_iam_member" "token_creator" {
  project = "${var.project_id}"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${var.vm_service_account}"
}

resource "google_project_iam_member" "log_writer" {
  project = "${var.project_id}"
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${var.vm_service_account}"
}

resource "google_project_iam_member" "log_viewer" {
  project = "${var.project_id}"
  role    = "roles/logging.viewer"
  member  = "serviceAccount:${var.vm_service_account}"
}
