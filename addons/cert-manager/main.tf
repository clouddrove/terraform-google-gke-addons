module "helm_addon" {
  source        = "../helm"
  helm_config   = local.helm_config
  project_id    = var.project_id
  environment   = var.environment
  addon_context = var.addon_context

  # set_values = [
  #   {
  #     name  = "installCRDs"
  #     value = "true"
  #   }
  # ]

  # -- IRSA Configurations
  # irsa_config = {
  #   environment  = var.environment
  #   project_id   = var.project_id
  #   GCP_GSA_NAME = "${local.name}-sa"
  #   GCP_KSA_NAME = "${local.name}-sa"
  #   namespace    = "kube-system"
  # }
}