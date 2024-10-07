variable "helm_config" {
  description = "Helm provider config for External DNS"
  type        = any
  default     = {}
}

variable "external_dns_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}
