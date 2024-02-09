module "cluster_autoscaler" {
  source                           = "./addons/cluster-autoscaler"
  count                            = var.cluster_autoscaler ? 1 : 0
  project_id                       = var.project_id
  gke_cluster_name                 = data.google_container_cluster.my_cluster.name
  cluster_autoscaler_extra_configs = var.cluster_autoscaler_extra_configs
  helm_config                      = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = [local_file.cluster_autoscaler_helm_config[count.index].content] }
}

module "reloader" {
  source                 = "./addons/reloader"
  count                  = var.reloader ? 1 : 0
  reloader_extra_configs = var.reloader_extra_configs
  helm_config            = var.reloader_helm_config != null ? var.reloader_helm_config : { values = [local_file.reloader_helm_config[count.index].content] }
}

module "ingress_nginx" {
  source                      = "./addons/ingress-nginx"
  count                       = var.ingress_nginx ? 1 : 0
  ingress_nginx_extra_configs = var.ingress_nginx_extra_configs
  helm_config                 = var.ingress_nginx_helm_config != null ? var.ingress_nginx_helm_config : { values = [local_file.ingress_nginx_helm_config[count.index].content] }
}

module "certification_manager" {
  source                              = "./addons/cert-manager"
  count                               = var.certification_manager ? 1 : 0
  certification_manager_extra_configs = var.certification_manager_extra_configs
  helm_config                         = var.certification_manager_helm_config != null ? var.certification_manager_helm_config : { values = [local_file.certification_manager_helm_config[count.index].content] }
}

module "keda" {
  source             = "./addons/keda"
  count              = var.keda ? 1 : 0
  keda_extra_configs = var.keda_extra_configs
  helm_config        = var.keda_helm_config != null ? var.keda_helm_config : { values = [local_file.keda_helm_config[count.index].content] }
}

module "external_dns" {
  source                     = "./addons/external-dns"
  count                      = var.external_dns ? 1 : 0
  project_id                 = var.project_id
  external_dns_extra_configs = var.external_dns_extra_configs
  helm_config                = var.external_dns_helm_config != null ? var.external_dns_helm_config : { values = [local_file.external_dns_helm_config[count.index].content] }
}

module "kubeclarity" {
  source                    = "./addons/kubeclarity"
  count                     = var.kubeclarity ? 1 : 0
  helm_config               = var.kubeclarity_helm_config != null ? var.kubeclarity_helm_config : { values = [local_file.kubeclarity_helm_config[count.index].content] }
  kubeclarity_extra_configs = var.kubeclarity_extra_configs
}

module "external_secrets" {
  source                         = "./addons/external-secrets"
  count                          = var.external_secrets ? 1 : 0
  external_secrets_extra_configs = var.external_secrets_extra_configs
  project_id                     = var.project_id
  helm_config                    = var.external_secrets_helm_config != null ? var.external_secrets_helm_config : { values = [local_file.external_secrets_helm_config[count.index].content] }
}