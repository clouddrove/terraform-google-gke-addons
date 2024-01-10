# variable "kubernetes_namespace" {
#   description = "Kubernetes Namespace name"
#   type        = string
# }

variable "create_kubernetes_namespace" {
  description = "Should the module create the namespace"
  type        = bool
  default     = true
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
}

variable "GCP_KSA_NAME" {
  description = "Google Kubernetes Service Account name"
  type        = string
}

variable "namespace" {
  description = "namespace for addons"
  type        = string
}