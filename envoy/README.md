# envoy

[envoy](https://www.envoyproxy.io/) is a cloud-native, high-performance edge/middle/service proxy.

## TL;DR;

```
$ helm install chatwork/envoy
```

## Prerequisites

* Kubernetes 1.14+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/envoy
```

The command deploys the envoy chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/envoy#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the envoy chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
| `nameOverride` | Override name of app | `""` |
| `fullnameOverride` | Override full name of app | `""` |
| `replicaCount` | Number of replicas | `1` |
| `image.repository` | The image repository to pull from | `envoyproxy/envoy` |
| `image.pullPolicy` | The image policy to pull | `IfNotPresent` |
| `image.tag` | The image tag to pull  | `"v1.19.1"` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `annotations` | Annotations to be added to deployment | `{}` |
| `labels` | labels to be added to deployment | `{}` |
| `command` | Additional command arguments | `[]` |
| `env` | Extra environment variables that will be passed onto pods | `[]` |
| `envFrom` | Extra environment from that will be passed onto pods | `[]` |
| `ports` | List of container ports | `[]` |
| `lifecycle` | Lifecycle hook script to execute | `{}` |
| `serviceAccount.create` | If true, create a service account for the pod | `true` |
| `serviceAccount.annotations` | Annotations for the created service account | `{}` |
| `serviceAccount.labels` | Labels for the created service account | `{}` |
| `serviceAccount.name` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""` |
| `podAnnotations` | Annotations to be added to pods | `{}` |
| `podLabels` | Labels to be added to pods | `{}` |
| `podSecurityContext` | security context applied to the pod | `{}` |
| `startupProbe` |  Container startup probe | `{}` |
| `livenessProbe` | Container liveness probe | `{}` |
| `readinessProbe` | Container readiness probe | `{}` |
| `securityContext` | Security context policies to add to the controller pod | `{}` |
| `priorityClassName` | Priority class name | `""` |
| `readinessGate` | The status of the pod will be ready when condition is true. | `[]` |
| `strategy` | Specifies the strategy used to replace old pods by new ones | `{}` |
| `topologySpreadConstraints` | Set topology spread constraints to control how Pods are spread across your cluster. This feature is available since 1.18 | `[]` |
| `terminationGracePeriodSeconds` | Termination grace period (in seconds) | `60` |
| `service.annotations` | Annotations to be added to service | `{}` |
| `service.labels` | Labels to be added to service | `{}` |
| `service.port` | The service port for http | `8081` |
| `service.targetPort` | The service targetPort for http | `10000` |
| `service.type` | The service type for http | `"ClusterIP"` |
| `ingress.enabled` | Enables Ingress | `false` |
| `ingress.annotations` | Annotation specified for ingress | `{}` |
| `ingress.labels` | Label specified for ingress | `{}` |
| `ingress.hosts` | Ingress accepted hostname | `[]` |
| `ingress.tls` | TLS Secret (certificates)  | `[]` |
| `ingress.ingressClassName` | Specifies ingressClass you use ingress controller. This feature is available since 1.18 and impremented by ingress controller | `""` |
| `resources` | Pod resource requests & limits | `{}` |
| `restartPolicy` | Container restart policy | `"Always"` |
| `podDisruptionBudget.enabled` | If true, create a pod disruption budget for keeper pods | `false` |
| `podDisruptionBudget.annotations` | Annotations for the created pod disruption budget | `{}` |
| `podDisruptionBudget.labels` | Labels for the created pod disruption budget | `{}` |
| `podDisruptionBudget.maxUnavailable` | Maximum number / percentage of pods that should remain scheduled | `` |
| `podDisruptionBudget.minAvailable` | Minimum number / percentage of pods that should remain scheduled | `` |
| `autoscaling.enabled` | If true, create a horizontal pod autoscaler for autoscaling | `false` |
| `autoscaling.annotations` | Annotations for the created horizontal pod autoscaler | `{}` |
| `autoscaling.labels` | Labels for the created horizontal pod autoscaler | `{}` |
| `autoscaling.minReplicas` | Min pods for HorizontalPodAutoscaler | `` |
| `autoscaling.maxReplicas` | Max pods for HorizontalPodAutoscaler | `` |
| `autoscaling.metrics` | Metrics used for HorizontalPodAutoscaler | `[]` |
| `autoscaling.behavior` | Behavior for HorizontalPodAutoscaler.  This feature is available since 1.18 | `{}` |
| `metrics.enabled` | If true, enable Prometheus metrics | `false` |
| `metrics.port` | Listen port | `9901` |
| `metrics.path` | Metrics HTTP endpoint | `/stats` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Node taints to tolerate | `[]` |
| `affinity` | Deployment affinities | `{}` |
| `initContainers` | Init containers to add to the replica pods | `[]` |
| `extraVolumeMounts` | Extra volume mounts variables that will be passed onto pods | `[]` |
| `extraVolumes` | Extra volumes variables that will be passed onto pods | `[]` |
| `extraContainers` | Extra containers variable that will be passed onto pods | `[]` |
| `configmaps` | Define configuration files and environment variables that can be expanded by tpl function | `{"envoy.yaml": "..."}` |

