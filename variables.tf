variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gke_cluster_name" {
  description = "gke cluster name"
  type        = string
  default     = ""
}

variable "region" {
  description = "cluster region"
  type        = string
  default     = ""
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

#-----------Ingress-Nginx----------------

variable "ingress_nginx_extra_configs" {
  description = "Nginx ingress extra config"
  type        = any
  default     = {}
}

variable "ingress_nginx_helm_config" {
  description = "Path to override-values.yaml for Ingress Nginx Helm Chart"
  type        = any
  default     = null
}

variable "ingress_nginx" {
  description = "Enable Nginx ingress add-on"
  type        = bool
  default     = false
}


#-----------CERTIFICATION-MANAGER----------------------
variable "certification_manager" {
  description = "Enable certification_manager add-on"
  type        = bool
  default     = false
}

variable "certification_manager_helm_config" {
  description = "Path to override-values.yaml for Certification Manager Chart"
  type        = any
  default     = null
}

variable "certification_manager_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- KEDA ----------------------------
variable "keda" {
  description = "Enable Keda add-on"
  type        = bool
  default     = false
}

variable "keda_helm_config" {
  description = "Path to override-values.yaml for Keda Helm Chart"
  type        = any
  default     = null
}

variable "keda_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#---------------EXTERNAL-SECRTE--------------------


variable "external_secrets" {
  description = "Enable or disable external-secrets deployment"
  type        = bool
  default     = false
}

variable "external_secrets_helm_config" {
  description = "Enable or disable external-secrets deployment"
  type        = bool
  default     = false
}

variable "external_secret_enabled" {
  description = "Enable or disable external-secrets deployment"
  type        = bool
  default     = false
}

variable "external_secrets_version" {
  description = "Version of the external-secret operator"
  type        = string
  default     = "0.8.3"
}

variable "service_monitor_crd_enabled" {
  description = "Enable or disable the installation of Custom Resource Definitions (CRDs) for Prometheus Service Monitor. "
  default     = false
  type        = bool
}

variable "name" {
  description = "The suffix name for the resources being created."
  type        = string
  default     = "gke"
}

variable "environment" {
  description = "Environment in which the infrastructure is being deployed (e.g., production, staging, development)"
  type        = string
}