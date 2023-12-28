variable "helm_config" {
  description = "Helm provider config for Cluster Autoscaler"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "gke_cluster_name" {
  type    = string
  default = ""
}
variable "project_id" {
  type    = string
  default = ""
}