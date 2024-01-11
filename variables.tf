variable "manage_via_gitops" {
  type        = bool
  default     = false
  description = "Set this to `true` if managing addons via GitOps. Seting `true` will not create helm-release for addon."
}

variable "tags" {
  description = "IRSA Input configuration for the addon_context"
  type        = any
  default     = {}
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gke_cluster_name" {
  type    = string
  default = ""
}

variable "environment" {
  description = "Environment in which the infrastructure is being deployed (e.g., production, staging, development)"
  type        = string
}

#-----------CLUSTER AUTOSCALER------------------
variable "cluster_autoscaler" {
  description = "Enable Cluster Autoscaler add-on"
  type        = bool
  default     = false
}

variable "cluster_autoscaler_helm_config" {
  description = "Path to override-values.yaml for Cluster Autoscaler Helm Chart"
  type        = any
  default     = null
}

variable "cluster_autoscaler_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}
#-----------RELOADER------------------

variable "reloader" {
  description = "Enable Reloader add-on"
  type        = bool
  default     = false
}

variable "reloader_helm_config" {
  description = "Path to override-values.yaml for Reloader Helm Chart"
  type        = any
  default     = null
}

variable "reloader_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}