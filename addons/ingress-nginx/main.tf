module "helm_addon" {
  source           = "../helm"
  helm_config      = local.helm_config
  project_id       = var.project_id
  environment      = var.environment
  addon_context    = var.addon_context
  namespace        = local.default_helm_config.namespace
  gke_cluster_name = var.gke_cluster_name
}