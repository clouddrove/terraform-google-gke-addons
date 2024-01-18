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
variable "c" {
  type    = any
  default = {}
}

# ------------------ RELOADER --------------------------------------------------
variable "reloader_extra_configs" {
  type    = any
  default = {}
}
