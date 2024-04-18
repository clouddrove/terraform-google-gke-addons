variable "helm_config" {
  description = "Helm provider config for AWS Load Balancer Controller"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "grafana_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "grafana_manifests" {
  type = object({
    grafana_virtualservice_file_path = string
  })
}