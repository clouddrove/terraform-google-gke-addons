#----------- CLUSTER AUTOSCALER ----------------
# output "cluster_autoscaler_service_account" {
#   value       = module.cluster_autoscaler[*].service_account
#   description = "name of cluster-autoscaler service-account"
# }
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
  value       = module.ingress-nginx[*].namespace
  description = "Namespace where ingress-nginx is installed"
}
output "ingress-nginx_chart_version" {
  value       = module.ingress-nginx[*].chart_version
  description = "chart version used for ingress-nginx helmchart"
}
output "ingress-nginx_repository" {
  value       = module.ingress-nginx[*].repository
  description = "helm repository url of ingress-nginx"
}
