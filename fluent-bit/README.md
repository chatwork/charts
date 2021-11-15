# Fluent Bit

[Fluent Bit](https://fluentbit.io/) is fast and lightweight log processor and forwarder.

## TL;DR;

```
$ helm install chatwork/fluent-bit
```

## Prerequisites

* Kubernetes 1.14+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/fluent-bit
```

The command deploys the slime chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/fluent-bit#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the slime chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
| `image.repository` | The image repository to pull from | `"fluent/fluent-bit"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `command` | Additional command arguments | `[]` |
| `nameOverride` | Override name of app | `""` |
| `fullnameOverride` | Override full name of app | `""` |
| `annotations` | Annotations to be added to daemonset | `{}` |
| `podAnnotations` | Annotations to be added to pods | `{}` |
| `serviceAccount.create` | If true, create a service account for the pod | `false` |
| `serviceAccount.annotations` | Annotations for the created service account | `{}` |
| `serviceAccount.name` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. | `nil` |
| `rbac.create` | If true, create & use RBAC resources | `false` |
| `podSecurityContext` | Security context policies to add to the controller pod | `{}` |
| `securityContext` | Allows you to overwrite the default securityContext applied to the container | `{}` |
| `env` | Extra environment variables that will be passed onto pods | `[]` |
| `resources` | Pod resource requests & limits | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Node taints to tolerate | `[]` |
| `affinity` | Node/Pod affinities | `{}` |
| `priorityClassName` | Priority Class Name | `""` |
| `metrics.enabled` | If true, enable Prometheus metrics | `false` |
| `metrics.port` | Prometheus metrics port | `2020` |
| `configmaps` | Configuration file to be mounted under /fluent-bit/etc | `{"fluent-bit.conf":"..."}` |
| `secrets` | Secret information file to be mounted under /secure | `{}` |
| `updateStrategy` | updateStrategy of daemonset | ... |
| `extraVolumeMounts` | Extra volume mounts variables that will be passed onto pods | `[]` |
| `extraVolumes` | Extra volumes variables that will be passed onto pods | `[]` |
| `useKubelet` | If true, set `hostNetwork:true`, and `dnsPolicy` to `ClusterFirstWithHostNet` FYI: [this page](https://docs.fluentbit.io/manual/pipeline/filters/kubernetes#optional-feature-using-kubelet-to-get-metadata) | `false` |
| `initContainers.enabled` | Enable initContainers | `false` |
| `initContainers.image.repository` | The image repository to pull from | `"busybox"` |
| `initContainers.image.tag` | The image tag | `"latest"` |
| `initContainers.image.pullPolicy` | Image pull policy | `"Always` |
| `initContainers.command` | Additional command arguments | `['sh', '-c', "until nslookup fluentd-forward.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for fluentd-forward; sleep 2; done"]`|
| `initContainers.env` | Extra environment variables that will be passed onto pods | `[]` |
| `initContainers.volumeMounts` | Extra volume mounts variables that will be passed onto pods | `[]` |

