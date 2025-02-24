module "istio_base" {
  source = "../helm"
  count  = try(var.istio_ingress_extra_configs.install_istiobase, true) ? 1 : 0

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istio_base.helm_config

 
}

module "istiod" {
  source = "../helm"
  count  = try(var.istio_ingress_extra_configs.install_istiod, true) ? 1 : 0

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istiod.helm_config
  
  depends_on = [module.istio_base]
}

module "istio_ingress" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  
  depends_on = [module.istiod]
}

