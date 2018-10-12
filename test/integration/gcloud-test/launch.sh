#!/bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#################################################################
#   PLEASE FILL THE VARIABLES WITH VALID VALUES FOR TESTING     #
#   DO NOT REMOVE ANY OF THE VARIABLES                          #
#################################################################

export PROJECT_ID="XXXXXX"
export ORG_ID="XXXXXX"
export FOLDER_ID="XXXXXX"
export BILLING_ID="XXXXXX-XXXXXX-XXXXXX"
export CREDENTIALS_PATH="XXXXXX"
export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=$CREDENTIALS_PATH
export SINK_NAME="integration-sink"
export STORAGE_BUCKET="XXXXXX-integration-sink"
export BIGQUERY_DATASET="integration_sink"
export PUBSUB_TOPIC="integration-sink"

# Cleans the workdir
function clean_workdir() {
  echo "Cleaning workdir"
  yes | rm -f terraform.tfstate*
  yes | rm -f *.tf
  yes | rm -rf .terraform
}

# Creates the main.tf file for Terraform
function create_main_tf_file() {
  echo "Creating main.tf file"
  touch main.tf
  cat <<EOF > main.tf
locals {
  credentials_file_path = "$CREDENTIALS_PATH"
}

provider "google" {
  credentials = "\${file(local.credentials_file_path)}"
}

module "gsuite-export-bq" {
  source          = "../../"
  service_account = "$SERVICE_ACCOUNT"
  api             = "reports_v1"
  applications    = "login drive token"
  admin_user      = "$ADMIN_USER"
  machine_name    = "test-exporter"
  machine_project = "$PROJECT_ID"
  export_name     = "test-export-bq"
  export_project  = "$PROJECT_ID"
  bigquery        = {
    name = "$BIGQUERY_DATASET"
    project = "$PROJECT_ID"
  }
}


module "gsuite-export-storage" {
  source          = "../../"
  service_account = "$SERVICE_ACCOUNT"
  api             = "reports_v1"
  applications    = "login drive token"
  admin_user      = "$ADMIN_USER"
  machine_name    = "test-exporter"
  machine_project = "$PROJECT_ID"
  export_name     = "test-export-storage"
  export_project  = "$PROJECT_ID"
  storage         = {
    name    = "$STORAGE_BUCKET"
    project = "$PROJECT_ID"
  }
}

module "gsuite-export" {
  source          = "../../"
  service_account = "$SERVICE_ACCOUNT"
  api             = "reports_v1"
  applications    = "login drive token"
  admin_user      = "$ADMIN_USER"
  machine_name    = "test-exporter"
  machine_project = "$PROJECT_ID"
  export_name     = "test-export-pubsub"
  export_project  = "$PROJECT_ID"
  pubsub        = {
    name    = "$PUBSUB_TOPIC"
    project = "$PROJECT_ID"
  }
}
EOF
}

# Creates the outputs.tf file
function create_outputs_file() {
  echo "Creating outputs.tf file"
  touch outputs.tf
  cat <<'EOF' > outputs.tf

  output "project_id" {
    value = "${module.pubsub_sink.sink["resource_name"]}"
  }

  output "folder_id" {
    value = "${module.storage_sink.sink["resource_name"]}"
  }

  output "org_id" {
    value = "${module.bigquery_sink.sink["resource_name"]}"
  }
EOF
}

# Preparing environment
clean_workdir
create_main_tf_file
create_outputs_file

# Call to bats
echo "Test to execute: $(bats integration.bats -c)"
bats integration.bats

export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=""
unset CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE

# Clean the environment
# clean_workdir
echo "Integration test finished"
