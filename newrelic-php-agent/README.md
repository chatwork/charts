# newrelic-php-agent

newrelic-php-agent is works the function of Newrelic's PHP agent process

## Prerequisites

* Kubernetes 1.11+

## Quick start
By default, the newrelic-php-agent runs in a DaemonSet.
### Installing the newrelic-php-agent Chart
```
helm install --name <RELEASE_NAME> \ chatwork/newrelic-php-agent
```

## Configuration options

The following table lists the configurable parameters of the newrelic-php-agent chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `newrelic.address` | Use `sockfile` if this value is a file path. Otherwise, use `containerPort`. input in the format `host:port`.  | `/tmp/.newrelic.sock` |
|  `newrelic.port` | When `sockfile` is not used, set `containerPort`  | `nil` |
| `image.repository` | The image repository to pull from | `chatwork/newrelic-php-agent`|
| `image.tag` | The image tag to pull | `9.4.0.249`|
| `image.imagePullPolicy` | Image pull policy | `IfNotPresent` |
| `image.command` | Image Entrypoint | `[]` |
| `image.pullSecrets` | Image PullSecrets | `[]` |
|  `livenessProbe` | Overrides the default liveness probe | `{}` |
|  `readinessProbe` | Overrides the default readness probe | `{}` |
|  `daemonset.enabled` | Enables daemonset | `true` |
|  `daemonset.useHostNetwork` | If true, use the host's network | `false` |
|  `daemonset.extraPorts` | Extra ports | `[]` |
|  `daemonset.extraEnv` | Extra env | `[]` |
|  `daemonset.extraEnvFrom` | Extra env form | `[]` |
|  `daemonset.extraVolumes` | Extra volumes | `[]` |
|  `daemonset.extraVolumeMounts` | Extra volume mounts | `[]` |
|  `daemonset.tolerations` | Set Pod tolerations | `[]`|
|  `daemonset.affinity` | Set Pod affinity | `{}`|
|  `daemonset.nodeSelector` | Set Pod nodeSelector | `{}`|
|  `daemonset.resources` | Pod resources | `{}`|
|  `deployment.enabled` | Enables deployment | `false` |
|  `deployment.replicaCount` | Deployment replicaCount | `1` |
|  `deployment.extraPorts` | Extra ports | `[]` |
|  `deployment.extraEnv` | Extra env | `[]` |
|  `deployment.extraEnvFrom` | Extra env form | `[]` |
|  `deployment.extraVolumes` | Extra volumes | `[]` |
|  `deployment.extraVolumeMounts` | Extra volume mounts | `[]` |
|  `deployment.tolerations` | Set Pod tolerations | `[]`|
|  `deployment.affinity` | Set Pod affinity | `{}`|
|  `deployment.nodeSelector` | Set Pod nodeSelector | `{}`|
|  `deployment.resources` | Pod resources | `{}`|
|  `ingress.enabled` | Enables Ingress | `false` |
|  `ingress.annotations` | Ingress annotations | `{}` |
|  `ingress.hosts` | Ingress accepted hostname | `[]` |
|  `ingress.tls` | TLS Secret (certificates) | `[]` |
|  `service.enabled` | Enables Service | `false` |
|  `service.type` | Changes to ClusterIP automatically if ingress enabled | `ClusterIP` |
|  `service.annotations` | Service annotations | `{}` |
|  `service.port` | Service port | `nil` |
|  `nameOverride` | Override name of app | `""` |
|  `fullnameOverride` | Override full name of app | `""` |