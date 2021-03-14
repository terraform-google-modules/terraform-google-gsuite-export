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
