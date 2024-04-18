
variable "helm_config" {
  description = "Helm provider config for prometheus"
  type        = any
  default     = {}
}

variable "prometheus_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}
