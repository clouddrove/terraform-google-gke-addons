locals {

  default_helm_config = {
    repository = try(var.external_secrets_extra_configs.repository, "https://charts.external-secrets.io/")
    version    = try(var.external_secrets_extra_configs.version, "0.9.11")
    namespace  = try(var.external_secrets_extra_configs.namespace, "secret")

  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
  )
}