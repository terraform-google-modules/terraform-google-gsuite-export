variable "project_id" {
    description = "The Project ID to provision resources into"
}

variable "region" {
    // To-Do: Add request to add region as parameter for cloudfunction resource
    description = "The Region to deploy the cloudfunction.  Currently this is only available in us-central-1"
    default = "us-central1"
}
variable "name" {
    description = "The Prefix for resource names"
    default = "demo-cf-export"
}

variable "gsuite_admin_user" {
    description = "The GSuite Admin user to impersonate"
}


variable "cs_schedule" {
    description = "The Schedule which to trigger the function"
    default = "*/10 * * * *"
 }

 variable "gsuite_exporter_service_account" {
     description = "The service account for exporting GSuite data. Needs domain-wide delegation and correct access scopes."
  }