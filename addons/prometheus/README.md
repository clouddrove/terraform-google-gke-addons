# Prometheus Agent Helm Chart

[Prometheus](https://prometheus.io/docs/introduction/overview/) offers an open-source monitoring and alerting toolkit designed especially for microservices and containers. Prometheus monitoring lets you run flexible queries and configure real-time notifications.

## Prerequisites
Persistent volume for Prometheus server and Alertmanager pods is disabled by default. Enable EBS or EFS CSI Driver from Addons or create EBS CSI driver manually from AWS EKS portal to enable Persistent volume for Prometheus server or Alertmanager.

## Dependencies
- [alertmanager](https://github.com/prometheus-community/helm-charts/tree/main/charts/alertmanager)
- [kube-state-metrics](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-state-metrics)
- [prometheus-node-exporter](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-node-exporter)
- [prometheus-pushgateway](https://github.com/walker-tom/helm-charts/tree/main/charts/prometheus-pushgateway)

## Installation
Below terraform script shows how to use Keda Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-google-gke-addons/blob/master/_examples/complete/main.tf).

```hcl
module "addons" {
  source  = "clouddrove/gke-addons/google"
  
  depends_on       = [module.gke.cluster_id]
  gke_cluster_name = module.gke.cluster_name

  prometheus             = true             # Update the licence key before using this add-on from ./config/override-prometheus.yaml
  prometheus_helm_config = { values = ["${file("./config/override-prometheus.yaml")}"] }
}
```

## Configuration
- Prometheus is a data scraper that will scrape the config from target and store it in Volume or Storge.
- Prometheus is used for Monitoring and Logging with Grafana service. Checkout [this](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/_examples/complete/config/grafana/override-grafana.yaml) Grafana default configuration to add Prometheus URL as a data-source for Grafana dashboard.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
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
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br>    
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for AWS Load Balancer Controller | `any` | `{}` | no |
| <a name="input_prometheus_extra_configs"></a> [prometheus\_extra\_configs](#input\_prometheus\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->