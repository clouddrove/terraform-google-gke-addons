variable "helm_config" {
  description = "Helm provider config for Actions Runner Controller"
  type        = any
  default     = {}
}

variable "actions_runner_controller_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}