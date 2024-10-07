variable "helm_config" {
  description = "Helm provider config for Cluster Autoscaler"
  type        = any
  default     = {}
}

variable "ingress_nginx_extra_configs" {
  description = "Nginx ingress extra config"
  type        = any
  default     = {}
}
