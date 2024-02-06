variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

# variable "name" {
#   description = "The suffix name for the resources being created."
#   type        = string
# }

variable "environment" {
  description = "Environment in which the infrastructure is being deployed (e.g., production, staging, development)"
  type        = string
}

variable "GCP_GSA_NAME" {
  description = "Google Cloud Service Account name"
  type        = string
  default     = "es"
}

variable "gke_cluster_name" {
  description = "gke cluster name"
  type        = string
  default     = ""
}

variable "GCP_KSA_NAME" {
  description = "Google Kubernetes Service Account name"
  type        = string
  default     = "external-secrets"
}

variable "enable_service_monitor" {
  description = "Enable or disable service monitor"
  type        = bool
  default     = false
}

variable "external_secrets_version" {
  description = "Version of the external-secret operator"
  type        = string
  default     = "0.9.11"
}

variable "name" {
  description = "The suffix name for the resources being created."
  type        = string
  default     = "gke-test"
}

variable "helm_config" {
  description = "Helm provider config for Metrics Server"
  type        = any
  default     = {}
}

variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}


variable "external_secrets_helm_config" {
  description = "Enable or disable external-secrets deployment"
  type        = any
  default     = false
}