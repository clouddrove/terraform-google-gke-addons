variable "helm_config" {
  description = "Helm provider config for grafana"
  type        = any
  default     = {}
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