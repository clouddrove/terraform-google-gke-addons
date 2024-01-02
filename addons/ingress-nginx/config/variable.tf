variable "helm_config" {
  description = "Helm provider config for Nginx Ingress"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "addon_context" {
  description = "Input configuration for the addon"
  type = object({
    # aws_caller_identity_account_id = string
    # aws_caller_identity_arn        = string
    gcp_gke_cluster_endpoint = string
    # aws_partition_id               = string
    gcp_region_name = string
    gke_cluster_id  = string
  })
}

variable "ingress_nginx_extra_configs" {
  description = "Nginx ingress extra config"
  type        = any
  default     = {}
}