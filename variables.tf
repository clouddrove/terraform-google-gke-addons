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

#-----------EXTERNAL DNS----------------------------
variable "external_dns" {
  description = "Enable External DNS add-on"
  type        = bool
  default     = false
}

variable "external_dns_helm_config" {
  description = "Path to override-values.yaml for External DNS Helm Chart"
  type        = any
  default     = null
}

variable "external_dns_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------KUBECLARITY---------------------------
variable "kubeclarity" {
  description = "Enable Kubeclarity add-on"
  type        = bool
  default     = false
}

variable "kubeclarity_helm_config" {
  description = "Path to override-values.yaml for Kubeclarity Helm Chart"
  type        = any
  default     = null
}

variable "kubeclarity_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------FILEBEAT---------------------------
variable "filebeat" {
  description = "Enable filebeat add-on"
  type        = bool
  default     = false
}

variable "filebeat_helm_config" {
  description = "Path to override-values.yaml for filebeat Helm Chart"
  type        = any
  default     = null
}

variable "filebeat_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#---------------EXTERNAL-SECRET--------------------
variable "external_secrets" {
  description = "Enable or disable external-secrets deployment"
  type        = bool
  default     = false
}

variable "external_secrets_helm_config" {
  description = "Path to override-values.yaml for External-Secrets Helm Chart"
  type        = any
  default     = null
}

variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------ACTIONS-RUNNER-CONTROLLER----------------------
variable "actions_runner_controller" {
  description = "Enable actions_runner_controller add-on"
  type        = bool
  default     = false
}

variable "actions_runner_controller_helm_config" {
  description = "Path to override-values.yaml for actions_runner_controller Chart"
  type        = any
  default     = null
}

variable "actions_runner_controller_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- REDIS ----------------------------
variable "redis" {
  description = "Enable Redis add-on"
  type        = bool
  default     = false
}

variable "redis_helm_config" {
  description = "Path to override-values.yaml for Redis Helm Chart"
  type        = any
  default     = null
}

variable "redis_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}