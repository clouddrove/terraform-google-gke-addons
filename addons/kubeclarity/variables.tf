variable "helm_config" {
  description = "Helm provider config for Metrics Server"
  type        = any
  default     = {}
}

variable "kubeclarity_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}
