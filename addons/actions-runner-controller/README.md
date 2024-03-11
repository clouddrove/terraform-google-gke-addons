# Actions Runner Controller Helm Chart

Actions Runner Controller is a Kubernetes addon to automate the management and issuance of TLS certificates from various issuing sources.
It will ensure certificates are valid and up to date periodically, and attempt to renew certificates at an appropriate time before expiry..

## Installation
Below terraform script shows how to use Actions Runner Controller Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
    source = "clouddrove/gke-addons/google"

    depends_on       = [module.gke]
    gke_cluster_name = module.gke.name
    project_id       = local.gcp_project_id
    region           = local.region

    actions_runner_controller   = true
}
```
## Prerequisite

Before you begin, make sure you have the following:

### Authentication for Self-Hosted Runners
Access to a GitHub repository for creating PAT and adding runners.

There are two ways for the actions-runner-controller to authenticate with the GitHub API (only 1 can be configured at a time, however) [mandetory]

Using a GitHub App (not supported for enterprise-level runners due to lack of support from GitHub)
Using a PAT(Personal Access Token) 
1. Using CLI:
   `kubectl create secret generic controller-manager -n actions-runner-system --from-literal=github_token=XXXXXX` 
2. pass secrets in override-actions-runner-controller.yaml
### Cert Manager on K8s cluster
Installing Cert Manager on K8s cluster.
Well, actions-runner-controller(ACR) uses cert-manager for certificate management of admission webhook, so we have to ensure cert-manager is installed on Kubernetes before installing actions-runner-controller.
Refer to this link for Cert Manager Installation via Helm [certification manager](https://artifacthub.io/packages/helm/cert-manager/cert-manager) also you can refere our addon module

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
| <a name="input_actions_runner_controller_extra_configs"></a> [actions\_runner\_controller\_extra\_configs](#input\_actions\_runner\_controller\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Actions Runner Controller | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
