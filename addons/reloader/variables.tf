variable "helm_config" {
  description = "Helm provider config for Cluster Autoscaler"
  type        = any
  default     = {}
}

variable "gke_cluster_name" {
  type    = string
  default = ""
}

variable "addon_context" {
  description = "Input configuration for the addon"
  type = object({
    gcp_region_name = string
    gke_cluster_id  = string
    tags            = map(string)
  })
}

variable "irsa_config" {
  description = "Input configuration for IRSA module"
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

variable "GCP_GSA_NAME" {
  description = "Google Cloud Service Account name"
  type        = string
  default     = "keda"
}

variable "GCP_KSA_NAME" {
  description = "Google Kubernetes Service Account name"
  type        = string
  default     = "keda-operator"
}

variable "reloader_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}


