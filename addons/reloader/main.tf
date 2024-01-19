module "helm_addon" {
  source      = "../helm"
  helm_config = local.helm_config
  project_id  = var.project_id
  environment = var.environment
  namespace   = local.default_helm_config.namespace
}