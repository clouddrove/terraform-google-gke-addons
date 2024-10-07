# Ingress Nginx Helm Chart

ingress-nginx is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer.

## Installation
Below terraform script shows how to use Ingress Nginx Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/main.tf).

- By default it will create 2 network load balancers 1 is internal type and 1 is internet facing type.
user can change this behaviour according to their need. They just have to change values in `/_example/complete/config/override-ingress-nginx.yaml` file. User can also add annotations according to their need or they can add their own config file by the same name.

- if user wants to change `namespace`, `chart version`, `timeout`, `atomic`  and other helm artributes, A complete list of artributes is also given here [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/addons/helm/main.tf#L3-L32). then they can change this in `/_example/complate/variable.tf` at
```bash
#--------------INGRESS NGINX------------
variable "ingress_nginx_extra_configs" {
  type = any
  default = {}
}
```

```bash
module "addons" {
  source = "clouddrove/gke-addons/google"

  depends_on       = [module.gke]
  gke_cluster_name = module.gke.name
  project_id       = local.gcp_project_id
  region           = local.regio

  ingress_nginx                  = true
  ingress_nginx_extra_configs    = var.ingress_nginx_extra_configs
  ingress_nginx_helm_config      = { values = ["${file("./config/override-ingress-nginx.yaml")}"] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.10.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_addon"></a> [helm\_addon](#module\_helm\_addon) | ../helm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Cluster Autoscaler | `any` | `{}` | no |
| <a name="input_ingress_nginx_extra_configs"></a> [ingress\_nginx\_extra\_configs](#input\_ingress\_nginx\_extra\_configs) | Nginx ingress extra config | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
