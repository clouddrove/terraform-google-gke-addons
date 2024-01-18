module "cluster_autoscaler" {
  source                           = "./addons/cluster-autoscaler"
  count                            = var.cluster_autoscaler ? 1 : 0
  environment                      = var.environment
  project_id                       = var.project_id
  gke_cluster_name                 = data.google_container_cluster.my_cluster.name
  addon_context                    = local.addon_context
  cluster_autoscaler_extra_configs = var.cluster_autoscaler_extra_configs
  helm_config                      = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = [local_file.cluster_autoscaler_helm_config[count.index].content] }
}

module "reloader" {
  source                 = "./addons/reloader"
  count                  = var.reloader ? 1 : 0
  environment            = var.environment
  project_id             = var.project_id
  gke_cluster_name       = data.google_container_cluster.my_cluster.name
  addon_context          = local.addon_context
  reloader_extra_configs = var.reloader_extra_configs
  helm_config            = var.reloader_helm_config != null ? var.reloader_helm_config : { values = [local_file.reloader_helm_config[count.index].content] }
}

module "ingress_nginx" {
  source                      = "./addons/ingress-nginx"
  count                       = var.ingress_nginx ? 1 : 0
  environment                 = var.environment
  project_id                  = var.project_id
  gke_cluster_name            = data.google_container_cluster.my_cluster.name
  addon_context               = local.addon_context
  ingress_nginx_extra_configs = var.ingress_nginx_extra_configs
  helm_config                 = var.ingress_nginx_helm_config != null ? var.ingress_nginx_helm_config : { values = [local_file.ingress_nginx_helm_config[count.index].content] }
}


module "certification_manager" {
  source                              = "./addons/cert-manager"
  count                               = var.certification_manager ? 1 : 0
  environment                         = var.environment
  project_id                          = var.project_id
  gke_cluster_name                    = data.google_container_cluster.my_cluster.name
  addon_context                       = local.addon_context
  certification_manager_extra_configs = var.certification_manager_extra_configs
  helm_config                         = var.certification_manager_helm_config != null ? var.certification_manager_helm_config : { values = [local_file.certification_manager_helm_config[count.index].content] }
}

module "keda" {
  source             = "./addons/keda"
  count              = var.keda ? 1 : 0
  environment        = var.environment
  project_id         = var.project_id
  addon_context      = local.addon_context
  keda_extra_configs = var.keda_extra_configs
  helm_config        = var.keda_helm_config != null ? var.keda_helm_config : { values = [local_file.keda_helm_config[count.index].content] }
}
