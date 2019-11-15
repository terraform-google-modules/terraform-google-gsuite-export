variable "pubsub" {
  description = "PubSub log export configuration"
  type = object({
    project = string
    name    = string
  })
}
