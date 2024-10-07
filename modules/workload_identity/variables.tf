variable "project_id" {
  description = "GCP project ID"
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
