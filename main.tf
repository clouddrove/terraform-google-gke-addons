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

module "filebeat" {
  source                 = "./addons/filebeat"
  count                  = var.filebeat ? 1 : 0
  helm_config            = var.filebeat_helm_config != null ? var.filebeat_helm_config : { values = [local_file.filebeat_helm_config[count.index].content] }
  filebeat_extra_configs = var.filebeat_extra_configs
}

module "external_secrets" {
  source                         = "./addons/external-secrets"
  count                          = var.external_secrets ? 1 : 0
  external_secrets_extra_configs = var.external_secrets_extra_configs
  project_id                     = var.project_id
  helm_config                    = var.external_secrets_helm_config != null ? var.external_secrets_helm_config : { values = [local_file.external_secrets_helm_config[count.index].content] }
}

module "actions_runner_controller" {
  depends_on                              = [module.certification_manager]
  count                                   = var.actions_runner_controller ? 1 : 0
  source                                  = "./addons/actions-runner-controller"
  helm_config                             = var.actions_runner_controller_helm_config != null ? var.actions_runner_controller_helm_config : { values = [local_file.actions_runner_controller_helm_config[count.index].content] }
  actions_runner_controller_extra_configs = var.actions_runner_controller_extra_configs
}

module "redis" {
  count               = var.redis ? 1 : 0
  source              = "./addons/redis"
  helm_config         = var.redis_helm_config != null ? var.redis_helm_config : { values = [local_file.redis_helm_config[count.index].content] }
  redis_extra_configs = var.redis_extra_configs
}

module "prometheus" {
  count                    = var.prometheus ? 1 : 0
  source                   = "./addons/prometheus"
  helm_config              = var.prometheus_helm_config != null ? var.prometheus_helm_config : { values = [local_file.prometheus_helm_config[0].content] }
  prometheus_extra_configs = var.prometheus_extra_configs
}

module "grafana" {
  count                 = var.grafana ? 1 : 0
  source                = "./addons/grafana"
  helm_config           = var.grafana_helm_config != null ? var.grafana_helm_config : { values = [local_file.grafana_helm_config[0].content] }
  grafana_manifests     = var.grafana_manifests
  grafana_extra_configs = var.grafana_extra_configs
}

module "istio_ingress" {
  count                       = var.istio_ingress ? 1 : 0
  source                      = "./addons/istio-ingress"
  helm_config                 = var.istio_ingress_helm_config != null ? var.istio_ingress_helm_config : { values = [local_file.istio_ingress_helm_config[count.index].content] }
  manage_via_gitops           = var.manage_via_gitops
}