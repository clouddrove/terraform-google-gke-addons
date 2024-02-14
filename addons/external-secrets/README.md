# External Secrets Helm Chart

External Secrets Operator is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault, Google Secrets Manager, Azure Key Vault, IBM Cloud Secrets Manager, Akeyless, CyberArk Conjur and many more. The operator reads information from external APIs and automatically injects the values into a Kubernetes Secret.

## Installation
Below terraform script shows how to use External Secrets Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/main.tf).

- User needs to change the properties (`name`,`namespace`,`region`) of SecretStore according to their usage by editing [secret-store.yaml](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/config/external-secret/secret-store.yaml)
and they also need to change properties (`name`,`namespace`,`secretKey`) of ExternalSecrets according to their usage by editing  [external-secret.yaml](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/config/external-secret/external-secret.yaml)

- Make sure to use same `namespace` in `externalsecret.yaml`,`secretstore.yaml` and in `pod/deployment.yaml`

- If users wants to add more secrets then they can use following template in `external-secret.yaml` under data:

```yml
data:
- secretKey: do_not_delete_this_key        # -- AWS Secret-Manager secret key
  remoteRef:
    key: addon-external_secrets            # -- Same as 'externalsecrets_manifest["secret_manager_name"]
    property: do_not_delete_this_key       # -- GCP Secret-Manager secret key
```
user also need to provide `secret_manager_name` inside `externalsecrets_manifest` variable in varriable.tf as below
```hcl
variable "externalsecrets_manifest" {
  type = object({
    secret_store_manifest_file_path     = string
    external_secrets_manifest_file_path = string
    secret_manager_name                 = string
  })
  default = {
    secret_store_manifest_file_path     = ""
    external_secrets_manifest_file_path = ""

    secret_manager_name                 = "addon/external_secrets"
  }
}
```

Calling `externalsecrets_manifest` variable in main.tf as below -
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.gke.cluster_id]
  gke_cluster_name = module.gke.cluster_name

  external_secrets         = true
  externalsecrets_manifest = var.externalsecrets_manifest
  
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

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_addon"></a> [helm\_addon](#module\_helm\_addon) | ../helm | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.secretadmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_secrets_extra_configs"></a> [external\_secrets\_extra\_configs](#input\_external\_secrets\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Metrics Server | `any` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Cloud project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->