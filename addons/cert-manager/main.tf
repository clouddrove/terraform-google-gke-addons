module "helm_addon" {
  source      = "../helm"
  helm_config = local.helm_config
  namespace   = local.default_helm_config.namespace
}