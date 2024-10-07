variable "helm_config" {
  description = "Helm provider config for Filebeat"
  type        = any
  default     = {}
}

variable "filebeat_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}
