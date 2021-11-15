# Terraform GSuite Export Module

The module will create a compute engine VM instance and set up a cronjob to export
GSuite Admin SDK data to **Stackdriver Logging** on a schedule.

Additional information on which APIs are supported is documented in the
[gsuite-exporter repository][gsuite-exporter-site].

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.0.0](https://registry.terraform.io/modules/terraform-google-modules/-gsuite-export/google/v1.0.0).

## Outputs

| Name | Description |
|------|-------------|
| filter | Log export filter for logs exported by GSuite-exporter |
| instance\_name | GSuite Exporter instance name |
| instance\_project | GSuite Exporter instance project |
| instance\_zone | GSuite Exporter instance zone |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements
### Terraform plugins
- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v1.8.0

### APIs
For the GSuite Exporter to work, the following APIs must be enabled in the project:
- Identity and Access Management API: `iam.googleapis.com`
- Admin SDK API: `admin.googleapis.com`

### Service account
We need two Terraform service accounts for this module:
* **Terraform service account** (that will create the GSuite Export VM)
* **VM service account** (that will be used on the VM to pull logs from GSuite and write them to Stackdriver Logging)

The **Terraform service account** used to run this module must have the following IAM Roles:
- `Compute Instance Admin` on the project (to create the VM)
- `Service Account User` on the project (to associate the VM service account with the VM)
- `Project IAM Admin` on the project (to grant permissions to the VM service account)

The **VM service account** passed to the module must have:
- GSuite domain-wide delegation enabled
- The following scopes in the [API client access page](https://admin.google.com/AdminHome?chromeless=1#OGX:ManageOauthClients)
  - https://www.googleapis.com/auth/admin.reports.audit.readonly (to read from the Reports API)
  - https://www.googleapis.com/auth/iam (to generate a super-admin token)


## Install

### Terraform
Be sure you have the correct Terraform version (0.12.x), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

Then perform the following commands:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

#### Variables
Please refer the `variables.tf` file for the required and optional variables.

#### Outputs
Please refer the `outputs.tf` file for the outputs that you can get with the `terraform output` command

## File structure
The project has the following folders and files:

- /: root folder
- /examples: examples for using this module
- /scripts: Shell scripts for specific tasks on module
- /test: Folders with files for testing the module (see Testing section on this file)
- /main.tf: main file for this module, contains all the resources to create
- /variables.tf: all the variables for the module
- /output.tf: the outputs of the module
- /readme.MD: this file

[gsuite-exporter-site]: https://github.com/GoogleCloudPlatform/professional-services/tree/master/tools/gsuite-exporter
