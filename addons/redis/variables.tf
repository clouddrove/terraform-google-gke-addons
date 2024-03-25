variable "helm_config" {
  description = "Helm provider config for Redis Cluster"
  type        = any
  default     = {}
}

variable "redis_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}