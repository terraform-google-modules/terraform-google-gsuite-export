#!/usr/bin/env bats

# #################################### #
#             Terraform tests          #
# #################################### #

@test "Ensure that Terraform configures the dirs and download the plugins" {

  run terraform init
  [ "$status" -eq 0 ]
}

@test "Ensure that Terraform updates the plugins" {

  run terraform get
  [ "$status" -eq 0 ]
}

@test "Terraform plan, ensure connection and creation of resources" {

  run terraform plan
  [ "$status" -eq 0 ]
  [[ "$output" =~ 16\ to\ add ]]
  [[ "$output" =~ 0\ to\ change ]]
  [[ "$output" =~ 0\ to\ destroy ]]
}

@test "Terraform apply" {

  run terraform apply -auto-approve
  [ "$status" -eq 0 ]
  [[ "$output" =~ 16\ added ]]
  [[ "$output" =~ 0\ changed ]]
  [[ "$output" =~ 0\ destroyed ]]
}

# #################################### #
#             gcloud tests             #
# #################################### #

@test "Test if VMs are running" {
  export INSTANCE_NAME="$(terraform output vm_name_bq)"
  run gcloud compute instances list --format='table(name, status)' --filter=name:$INSTANCE_NAME
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" = "destination: $SINK_DESTINATION" ]]
  [[ "${lines[2]}" = "name: $SINK_NAME" ]]
  [[ "${lines[3]}" = "writerIdentity: $SINK_WRITER" ]]
}

# #################################### #
#      Terraform destroy test          #
# #################################### #

@test "Terraform destroy" {

  run terraform destroy -force
  [ "$status" -eq 0 ]
  [[ "$output" =~ 16\ destroyed ]]
}
