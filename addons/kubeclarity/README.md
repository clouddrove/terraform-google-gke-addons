# Kubeclarity Helm Chart

KubeClarity is a tool for detecting and managing Software Bill of Materials (SBOM) and vulnerabilities of container images and filesystems. It scans runtime Kubernetes clusters and CI/CD pipelines to generate SBOM documents and vulnerability reports for enhanced software supply chain security.

## Installation
Below terraform script shows how to use Reloader Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/main.tf).

```bash
module "addons" {
  source = "git::https://github.dev/clouddrove/terraform-google-gke-addons"

  depends_on       = [module.gke]
  gke_cluster_name = module.gke.name
  project_id       = local.gcp_project_id
  region           = local.region

  reloader = true
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
| <a name="input_reloader_extra_configs"></a> [kubeclarity\_extra\_configs](#input\_kubeclarity\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Note:

- For check vulnerabilities of container images and filesystems using `kubeclarity` ``dashboard`` go on Runtime-scan on Dashboard and filter out as per namespace you want.

![image](https://github.com/clouddrove/terraform-google-gke-addons/assets/116706588/f0354df3-cb7e-4db8-84ae-d8bd0116151e)
