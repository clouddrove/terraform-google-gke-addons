variable "helm_config" {
  description = "Helm provider config for Cluster Autoscaler"
  type        = any
  default     = {}
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "environment" {
  description = "Environment in which the infrastructure is being deployed (e.g., production, staging, development)"
  type        = string
}

variable "reloader_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}


