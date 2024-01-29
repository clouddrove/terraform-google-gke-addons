#----------- CLUSTER AUTOSCALER ----------------
output "cluster_autoscaler_namespace" {
  value       = module.cluster_autoscaler[*].namespace
  description = "Namespace where cluster-autoscaler is installed"
}
output "cluster_autoscaler_chart_version" {
  value       = module.cluster_autoscaler[*].chart_version
  description = "chart version used for cluster-autoscaler helmchart"
}
output "cluster_autoscaler_repository" {
  value       = module.cluster_autoscaler[*].repository
  description = "helm repository url of cluster-autoscaler"
}

#----------- CERTICATION-MANAGER ------------------------
output "certification_manager_namespace" {
  value       = module.certification_manager[*].namespace
  description = "The namespace where certification-manager is deployed."
}
output "certification_manager_chart_version" {
  value       = module.certification_manager[*].chart_version
  description = "Chart version of the certification-manager Helm Chart."
}
output "certification_manager_repository" {
  value       = module.certification_manager[*].repository
  description = "Helm chart repository of the certification-manager."
}

#----------- RELOADER ----------------------------------
output "reloader_namespace" {
  value       = module.reloader[*].namespace
  description = "The namespace where reloader is deployed."
}
output "reloader_chart_version" {
  value       = module.reloader[*].chart_version
  description = "Chart version of the reloader Helm Chart."
}
output "reloader_repository" {
  value       = module.reloader[*].repository
  description = "Helm chart repository of the reloader."
}

#----------- INGRESS NGINX ---------------------
output "ingress-nginx_namespace" {
  value       = module.ingress_nginx[*].namespace
  description = "Namespace where ingress-nginx is installed"
}
output "ingress-nginx_chart_version" {
  value       = module.ingress_nginx[*].chart_version
  description = "chart version used for ingress-nginx helmchart"
}
output "ingress-nginx_repository" {
  value       = module.ingress_nginx[*].repository
  description = "helm repository url of ingress-nginx"
}

#----------- KEDA ---------------------
output "keda_namespace" {
  value       = module.keda[*].namespace
  description = "Namespace where keda is installed"
}
output "keda_chart_version" {
  value       = module.keda[*].chart_version
  description = "chart version used for keda helmchart"
}
output "keda_repository" {
  value       = module.keda[*].repository
  description = "helm repository url of keda"
}

#-----------Kubeclarity-------------------
output "namespace" {
  value = local.default_helm_config.namespace
}

output "chart_version" {
  value = local.default_helm_config.version
}

output "repository" {
  value = local.default_helm_config.repository
}

