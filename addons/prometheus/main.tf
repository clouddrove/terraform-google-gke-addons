module "helm_addon" {
  source = "../helm"

  helm_config = local.helm_config
}
