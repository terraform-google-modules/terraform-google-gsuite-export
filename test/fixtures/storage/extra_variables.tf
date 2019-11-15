variable "storage" {
  description = "Storage log export configuration"
  type = object({
    project = string
    name    = string
  })
}
