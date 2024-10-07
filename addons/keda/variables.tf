variable "helm_config" {
  description = "Helm provider config for Keda"
  type        = any
  default     = {}
}

variable "keda_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}
