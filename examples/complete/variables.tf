# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# ------------------ CLUSTER AUTOSCALER ----------------------------------------
variable "cluster_autoscaler_extra_configs" {
  type    = any
  default = {}
}

# ------------------ NGINX INGRESS ---------------------------------------------
variable "ingress_nginx_extra_configs" {
  type    = any
  default = {}
}

# ------------------ CERTIFICATION-MANAGER -----------------------------------------------------
variable "certification_manager_extra_configs" {
  type    = any
  default = {}
}

# ------------------ RELOADER --------------------------------------------------
variable "reloader_extra_configs" {
  type    = any
  default = {}
}

# ------------------ KEDA -----------------------------------------------------
variable "keda_extra_configs" {
  type    = any
  default = {}
}

# ------------------ EXTERNAL DNS --------------------------------------------------
variable "external_dns_extra_configs" {
  type    = any
  default = {}
}
#------------------- KUBECLARITY -------------------------------------------------
variable "kubeclarity_extra_configs" {
  type    = any
  default = {}
}

#------------------- FILEBEAT -------------------------------------------------
variable "filebeat_extra_configs" {
  type    = any
  default = {}
}

# ------------------ EXTERNAL SECRET ------------------------------------------
variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

# ------------------ ACTIONS-RUNNER-CONTROLLER -----------------------------------------------------
variable "actions_runner_controller_extra_configs" {
  type    = any
  default = {}
}

# ------------------ REDIS --------------------------------------------------
variable "redis_extra_configs" {
  type = any
  default = {
    atomic  = true
    timeout = 300
  }
}

# ------------------ PROMETHEUS --------------------------------------------------
variable "prometheus_extra_configs" {
  type = any
  default = {
    atomic = true
  }
}
