variable "helm_config" {
  description = "Helm chart config. Repository and version required. See https://registry.terraform.io/providers/hashicorp/helm/latest/docs"
  type        = any
  default     = {}
}

variable "set_values" {
  description = "Forced set values"
  type        = any
  default     = []
}

variable "set_sensitive_values" {
  description = "Forced set_sensitive values"
  type        = any
  default     = []
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "workload_identity_config" {
  description = "Input configuration for workload identity module"
  type        = any
  default     = {}
}

variable "addon_context" {
  description = "workload identity Input configuration for the addon"
  type        = any
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}


variable "create_kubernetes_namespace" {
  description = "Should the module create the namespace"
  type        = bool
  default     = true
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

variable "namespace" {
  description = "Google Kubernetes Service Account name"
  type        = string
  default     = "kube-system"
}
