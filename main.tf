module "cluster_autoscaler" {
  source           = "./addons/cluster-autoscaler"
  count            = var.cluster_autoscaler ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
  helm_config      = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = [local_file.cluster_autoscaler_helm_config[count.index].content] }
}

module "reloader" {
  source           = "./addons/reloader"
  count            = var.reloader ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
  helm_config      = var.reloader_helm_config != null ? var.reloader_helm_config : { values = [local_file.reloader_helm_config[count.index].content] }
}

module "ingress-nginx" {
  source           = "./addons/ingress-nginx"
  count            = var.ingress-nginx ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
  helm_config      = var.istio_ingress_helm_config != null ? var.istio_ingress_helm_config : { values = [local_file.istio_ingress_helm_config[count.index].content] }
}


module "certification_manager" {
  source           = "./addons/cert-manager"
  count            = var.certification_manager ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
  helm_config      = var.certification_manager_helm_config != null ? var.certification_manager_helm_config : { values = [local_file.certification_manager_helm_config[count.index].content] }
}

