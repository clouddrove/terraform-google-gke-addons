variable "helm_config" {
  description = "Helm provider config for Cluster Autoscaler"
  type        = any
  default     = {}
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "ingress_nginx_extra_configs" {
  description = "Nginx ingress extra config"
  type        = any
  default     = {}
}

variable "environment" {
  description = "Environment in which the infrastructure is being deployed (e.g., production, staging, development)"
  type        = string
}

