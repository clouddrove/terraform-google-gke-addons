## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actions\_runner\_controller | Enable actions\_runner\_controller add-on | `bool` | `false` | no |
| actions\_runner\_controller\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| actions\_runner\_controller\_helm\_config | Path to override-values.yaml for actions\_runner\_controller Chart | `any` | `null` | no |
| certification\_manager | Enable certification\_manager add-on | `bool` | `false` | no |
| certification\_manager\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| certification\_manager\_helm\_config | Path to override-values.yaml for Certification Manager Chart | `any` | `null` | no |
| cluster\_autoscaler | Enable Cluster Autoscaler add-on | `bool` | `false` | no |
| cluster\_autoscaler\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| cluster\_autoscaler\_helm\_config | Path to override-values.yaml for Cluster Autoscaler Helm Chart | `any` | `null` | no |
| external\_dns | Enable External DNS add-on | `bool` | `false` | no |
| external\_dns\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| external\_dns\_helm\_config | Path to override-values.yaml for External DNS Helm Chart | `any` | `null` | no |
| external\_secrets | Enable or disable external-secrets deployment | `bool` | `false` | no |
| external\_secrets\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| external\_secrets\_helm\_config | Path to override-values.yaml for External-Secrets Helm Chart | `any` | `null` | no |
| filebeat | Enable filebeat add-on | `bool` | `false` | no |
| filebeat\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| filebeat\_helm\_config | Path to override-values.yaml for filebeat Helm Chart | `any` | `null` | no |
| gke\_cluster\_name | gke cluster name | `string` | `""` | no |
| ingress\_nginx | Enable Nginx ingress add-on | `bool` | `false` | no |
| ingress\_nginx\_extra\_configs | Nginx ingress extra config | `any` | `{}` | no |
| ingress\_nginx\_helm\_config | Path to override-values.yaml for Ingress Nginx Helm Chart | `any` | `null` | no |
| keda | Enable Keda add-on | `bool` | `false` | no |
| keda\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| keda\_helm\_config | Path to override-values.yaml for Keda Helm Chart | `any` | `null` | no |
| kubeclarity | Enable Kubeclarity add-on | `bool` | `false` | no |
| kubeclarity\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| kubeclarity\_helm\_config | Path to override-values.yaml for Kubeclarity Helm Chart | `any` | `null` | no |
| project\_id | GCP project ID | `string` | n/a | yes |
| prometheus | Enable prometheus add-on | `bool` | `false` | no |
| prometheus\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| prometheus\_helm\_config | Prometheus Helm Chart config | `any` | `null` | no |
| redis | Enable Redis add-on | `bool` | `false` | no |
| redis\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| redis\_helm\_config | Path to override-values.yaml for Redis Helm Chart | `any` | `null` | no |
| region | cluster region | `string` | `""` | no |
| reloader | Enable Reloader add-on | `bool` | `false` | no |
| reloader\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| reloader\_helm\_config | Path to override-values.yaml for Reloader Helm Chart | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| actions\_runner\_controller\_chart\_version | Chart version of the actions\_runner\_controller Helm Chart. |
| actions\_runner\_controller\_namespace | The namespace where actions\_runner\_controller is deployed. |
| actions\_runner\_controller\_repository | Helm chart repository of the actions\_runner\_controller. |
| certification\_manager\_chart\_version | Chart version of the certification-manager Helm Chart. |
| certification\_manager\_namespace | The namespace where certification-manager is deployed. |
| certification\_manager\_repository | Helm chart repository of the certification-manager. |
| cluster\_autoscaler\_chart\_version | chart version used for cluster-autoscaler helmchart |
| cluster\_autoscaler\_namespace | Namespace where cluster-autoscaler is installed |
| cluster\_autoscaler\_repository | helm repository url of cluster-autoscaler |
| external\_dns\_chart\_version | chart version used for external DNS helmchart |
| external\_dns\_namespace | Namespace where external DNS is installed |
| external\_dns\_repository | helm repository url of external DNS |
| external\_secrets\_chart\_version | chart version used for external secrets helmchart |
| external\_secrets\_namespace | Namespace where external secrets is installed |
| external\_secrets\_repository | helm repository url of external secrets |
| filebeat\_chart\_version | chart version used for filebeat helmchart |
| filebeat\_namespace | Namespace where filebeat is installed |
| filebeat\_repository | helm repository url of filebeat |
| ingress-nginx\_chart\_version | chart version used for ingress-nginx helmchart |
| ingress-nginx\_namespace | Namespace where ingress-nginx is installed |
| ingress-nginx\_repository | helm repository url of ingress-nginx |
| keda\_chart\_version | chart version used for keda helmchart |
| keda\_namespace | Namespace where keda is installed |
| keda\_repository | helm repository url of keda |
| kubeclarity\_chart\_version | chart version used for kubeclarity helmchart |
| kubeclarity\_namespace | Namespace where kubeclarity is installed |
| kubeclarity\_repository | helm repository url of kubeclarity |
| prometheus\_chart\_version | Chart version of the prometheus Helm Chart. |
| prometheus\_namespace | The namespace where prometheus is deployed. |
| prometheus\_repository | Helm chart repository of the prometheus. |
| redis\_chart\_version | Chart version of the Redis Helm Chart. |
| redis\_namespace | The namespace where Redis is deployed. |
| redis\_repository | Helm chart repository of the Redis. |
| reloader\_chart\_version | Chart version of the reloader Helm Chart. |
| reloader\_namespace | The namespace where reloader is deployed. |
| reloader\_repository | Helm chart repository of the reloader. |

