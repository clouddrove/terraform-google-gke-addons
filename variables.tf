# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
#-----------METRIC SERVER----------------------
# variable "metrics_server" {
#   description = "Enable metrics server add-on"
#   type        = bool
#   default     = false
# }

# variable "metrics_server_helm_config" {
#   description = "Path to override-values.yaml for Metrics Server Helm Chart"
#   type        = any
#   default     = null
# }

# variable "metrics_server_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

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

variable "cluster_autoscaler_iampolicy_json_content" {
  description = "Custom IAM Policy for ClusterAutoscaler IRSA"
  type        = string
  default     = null
}

#-----------gcp LOAD BALANCER CONTROLLER --------
variable "gcp_load_balancer_controller" {
  description = "Enable gcp Load Balancer Controller add-on"
  type        = bool
  default     = false
}

variable "gcp_load_balancer_controller_helm_config" {
  description = "Path to override-values.yaml for gcp Load Balancer Controller Helm Chart"
  type        = any
  default     = null
}

variable "gcp_load_balancer_controller_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "gcp_load_balancer_controller_iampolicy_json_content" {
  description = "Custom IAM Policy for Load Balancer Controller IRSA"
  type        = string
  default     = null
}

#-----------gcp NODE TERMINATION HANDLER --------
variable "gcp_node_termination_handler" {
  description = "Enable gcp Node Termination Handler add-on"
  type        = bool
  default     = false
}

variable "gcp_node_termination_handler_helm_config" {
  description = "Path to override-values.yaml for gcp Node Termination Handler Helm Chart"
  type        = any
  default     = null
}

variable "gcp_node_termination_handler_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}


#-----------KARPENTER -----------------------------
variable "karpenter" {
  description = "Enable KARPENTER add-on"
  type        = bool
  default     = false
}

variable "karpenter_helm_config" {
  description = "Path to override-values.yaml for Karpenter Helm Chart"
  type        = any
  default     = null
}

variable "karpenter_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "karpenter_iampolicy_json_content" {
  description = "Custom IAM Policy for Karpenter IRSA"
  type        = string
  default     = null
}



#----------- EXTERNAL SECRETS ---------------------
# variable "external_secrets" {
#   description = "Enable External-Secrets add-on"
#   type        = bool
#   default     = false
# }

# variable "external_secrets_helm_config" {
#   description = "Path to override-values.yaml for External-Secrets Helm Chart"
#   type        = any
#   default     = null
# }

# variable "external_secrets_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

# variable "external_secrets_iampolicy_json_content" {
#   description = "Custom IAM Policy for External-Secrets IRSA"
#   type        = string
#   default     = null
# }

# #------------------ INGRESS NGINX -------------------------
# variable "ingress_nginx" {
#   description = "Enable ingress nginx add-on"
#   type        = bool
#   default     = false
# }

# variable "ingress_nginx_helm_config" {
#   description = "Path to override-values.yaml for Ingress Nginx Helm Chart"
#   type        = any
#   default     = null
# }

# variable "ingress_nginx_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = null
# }

# #-----------KUBECLARITY---------------------------
# variable "kubeclarity" {
#   description = "Enable Kubeclarity add-on"
#   type        = bool
#   default     = false
# }

# variable "kubeclarity_helm_config" {
#   description = "Path to override-values.yaml for Kubeclarity Helm Chart"
#   type        = any
#   default     = null
# }

# variable "kubeclarity_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

# #----------- NEW RELIC AGENT ----------------------
# variable "new_relic" {
#   description = "Enable New-Relic-Agent add-on"
#   type        = bool
#   default     = false
# }

# variable "new_relic_helm_config" {
#   description = "New-Relic Helm Chart config"
#   type        = any
#   default     = null
# }

# variable "new_relic_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

#----------- KUBE STATE METRICS ----------------------
# variable "kube_state_metrics" {
#   description = "Enable Kube-State-Metrics add-on"
#   type        = bool
#   default     = false
# }

# variable "kube_state_metrics_helm_config" {
#   description = "Kube-State-Metrics Helm Chart config"
#   type        = any
#   default     = null
# }

# variable "kube_state_metrics_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

#-----------COMMON VARIABLES -----------------------
# variable "tags" {
#   description = "IRSA Input configuration for the addon_context"
#   type        = any
#   default     = {}
# }

# variable "irsa_iam_role_path" {
#   description = "IRSA Input configuration for the addon_context"
#   type        = any
#   default     = {}
# }

# variable "irsa_iam_permissions_boundary" {
#   description = "IRSA Input configuration for the addon_context"
#   type        = any
#   default     = {}
# }

variable "manage_via_gitops" {
  type        = bool
  default     = false
  description = "Set this to `true` if managing addons via GitOps. Seting `true` will not create helm-release for addon."
}

variable "data_plane_wait_arn" {
  description = "This waits for the data plane to be ready"
  type        = string
  default     = ""
}

variable "gke_cluster_name" {
  description = "Name of gke cluster"
  type        = string
  default     = ""
}





# #----------- KEDA ----------------------------
# variable "keda" {
#   description = "Enable Keda add-on"
#   type        = bool
#   default     = false
# }

# variable "keda_helm_config" {
#   description = "Path to override-values.yaml for Keda Helm Chart"
#   type        = any
#   default     = null
# }

# variable "keda_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

#-----------CERTIFICATION-MANAGER----------------------
# variable "certification_manager" {
#   description = "Enable certification_manager add-on"
#   type        = bool
#   default     = false
# }

# variable "certification_manager_helm_config" {
#   description = "Path to override-values.yaml for Certification Manager Chart"
#   type        = any
#   default     = null
# }

# variable "certification_manager_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }


#----------- EXTERNAL DNS ----------------------------
# variable "external_dns" {
#   description = "Enable External DNS add-on"
#   type        = bool
#   default     = false
# }

# variable "external_dns_helm_config" {
#   description = "Path to override-values.yaml for External DNS Helm Chart"
#   type        = any
#   default     = null
# }

# variable "external_dns_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }

# variable "external_dns_iampolicy_json_content" {
#   description = "Custom IAM Policy for External DNS"
#   type        = string
#   default     = null
# }

#----------- REDIS ----------------------------
# variable "redis" {
#   description = "Enable Redis add-on"
#   type        = bool
#   default     = false
# }

# variable "redis_helm_config" {
#   description = "Path to override-values.yaml for Redis Helm Chart"
#   type        = any
#   default     = null
# }

# variable "redis_extra_configs" {
#   description = "Override attributes of helm_release terraform resource"
#   type        = any
#   default     = {}
# }
