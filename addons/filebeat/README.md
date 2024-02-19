# Filebeat Helm Chart

Filebeat helps you keep the simple things simple by offering a lightweight way to forward and centralize logs and files.

## Installation
Below terraform script shows how to use Cluster Autoscaler Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/main.tf).

```hcl
module "addons" {
  source = "git::https://github.dev/clouddrove/terraform-google-gke-addons"

  depends_on       = [module.gke]
  gke_cluster_name = module.gke.name
  project_id       = local.gcp_project_id
  region           = local.region

  filebeat    = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->