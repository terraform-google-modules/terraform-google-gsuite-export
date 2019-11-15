variable "bigquery" {
  description = "BigQuery log export configuration"
  type = object({
    project = string
    name    = string
  })
}
