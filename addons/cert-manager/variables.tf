variable "helm_config" {
  description = "Helm provider config for Cluster Autoscaler"
  type        = any
  default     = {}
}

variable "certification_manager_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}
