# External DNS Helm Chart

External DNS manages the following AWS resources
- Configure external DNS servers (AWS Route53, Google CloudDNS and others) for Kubernetes Ingresses and Services.

- ExternalDNS is a Kubernetes addon that configures public DNS servers with information about exposed Kubernetes services to make them discoverable.

## Installation
Below terraform script shows how to use External DNS Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "git::https://github.dev/clouddrove/terraform-google-gke-addons"
  
  depends_on       = [module.gke]
  gke_cluster_name = module.gke.name
  project_id       = local.gcp_project_id
  region           = local.region

  external_dns = true
}
```