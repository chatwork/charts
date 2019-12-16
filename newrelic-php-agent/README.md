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
| `image.repository` | The image repository to pull from | `chatwork/newrelic-php-agent`|
| `image.tag` | The image tag to pull | `0.0.1`|
| `image.imagePullPolicy` | Image pull policy | `IfNotPresent` |
| `image.command` | Image Entrypoint | `[]` |
|  `livenessProbe` | Overrides the default liveness probe | tcpSocket port `31339` |
|  `readinessProbe` | Overrides the default readness probe | tcpSocket port `31339` |
|  `address` | Use `sockfile` if this value is a file path. In other cases, use `containerPort`  | `/tmp/.newrelic.sock` |
|  `daemonset.enabled` | Enables daemonset | `TRUE` |
|  `daemonset.extraPorts` | Extra ports | `[]` |
|  `daemonset.extraEnv` | Extra env | `[]` |
|  `daemonset.extraEnvFrom` | Extra env form | `[]` |
|  `daemonset.extraVolumes` | Extra volumes | `[]` |
|  `daemonset.extraVolumeMounts` | Extra volume mounts | `[]` |
|  `deployment.enabled` | Enables deployment | `FALSE` |
|  `deployment.replicaCount` | Deployment replicaCount | `1` |
|  `deployment.extraPorts` | Extra ports | `[]` |
|  `deployment.extraEnv` | Extra env | `[]` |
|  `deployment.extraEnvFrom` | Extra env form | `[]` |
|  `deployment.extraVolumes` | Extra volumes | `[]` |
|  `deployment.extraVolumeMounts` | Extra volume mounts | `[]` |
|  `ingress.enabled` | Enables Ingress | `FALSE` |
|  `service.type` | Changes to ClusterIP automatically if ingress enabled | `ClusterIP` |
|  `service.port` | Port to advertise the main web service in ClusterIP mode | `31339` |