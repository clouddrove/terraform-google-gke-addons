variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "helm_config" {
  description = "Helm provider config for Metrics Server"
  type        = any
  default     = {}
}

variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "external_secrets_helm_config" {
  description = "Enable or disable external-secrets deployment"
  type        = any
  default     = false
}