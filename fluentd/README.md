# Fluentd

[Fluentd](https://www.fluentd.org/) is an open source data collector for unified logging layer.

## TL;DR;

```
$ helm install chatwork/fluentd
```

## Prerequisites

* Kubernetes 1.14+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/fluentd
```

The command deploys the slime chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/fluentd#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the fluentd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
| `image.repository` | The image repository to pull from | `"chatwork/fluentd"` |
| `image.tag` | The image tag to pull | `"1.10.4"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `nameOverride` | Override name of app | `""` |
| `fullnameOverride` | Override full name of app | `""` |
| `fluentd.http.enabled` | If true, use http input | `true` |
| `fluentd.http.id` | Used to add the unique name of plugin configuration | `nil` |
| `fluentd.http.label` | Route input events to <label> sections | `nil` |
| `fluentd.http.logLevel` | Plugin-specific logging level | `nil` |
| `fluentd.http.port` | The port to listen to | `9880` |
| `fluentd.http.bind` | The bind address to listen to | `"0.0.0.0"` |
| `fluentd.http.bodySizeLimit` | The size limit of the POSTed element | `"32m"` |
| `fluentd.http.keepaliveTimeout` | The timeout limit for keeping the connection alive | `"10s"` |
| `fluentd.http.addHttpHeaders` | Add HTTP_ prefix headers to the record | `false` |
| `fluentd.http.addRemoteAddr` | Add REMOTE_ADDR field to the record. The value of REMOTE_ADDR is the client's address | `false` |
| `fluentd.http.corsAllowOrigins` | White list domains for CORS | `[]` |
| `fluentd.http.respondWithEmptyImg` | Respond with an empty gif image of 1x1 pixel (rather than an emtpy string) | `false` |
| `fluentd.http.tls.enabled` | If true, using TLS transport | `false` |
| `fluentd.http.tls.certPath` | Cert path to use with TLS | `""` |
| `fluentd.http.service.enabled` | If true, use service for http input | `false` |
| `fluentd.http.service.annotations` | Annotations to be added to service | `{}` |
| `fluentd.http.service.labels` | Labels to be added to daemonset | `{}` |
| `fluentd.http.service.port` | The service port for http input | `9880` |
| `fluentd.http.service.type` | The service type for http input | `"ClusterIP"` |
| `fluentd.forward.enabled` | If true, use forward input | `true` |
| `fluentd.forward.id` | Used to add the unique name of plugin configuration | `nil` |
| `fluentd.forward.label` | Route input events to <label> sections | `nil` |
| `fluentd.forward.logLevel` | Plugin-specific logging level | `nil` |
| `fluentd.forward.port` | The port to listen to | `24224` |
| `fluentd.forward.bind` | The bind address to listen to | `"0.0.0.0"` |
| `fluentd.forward.tag` | in_forward uses incoming event's tag by default(See "Protocol" section). If set tag parameter, use its value instead | `""` |
| `fluentd.forward.addTagPrefix` | Add prefix to incoming event's tag | `nil` |
| `fluentd.forward.lingerTimeout` | The timeout time used to set linger option | `0` |
| `fluentd.forward.resolveHostname` | Try to resolve hostname from IP addresses or not | `false` |
| `fluentd.forward.denyKeepalive` | Connections will be disconnected right after receiving first message if this value is true | `false` |
| `fluentd.forward.sendKeepalivePacket` | Enable TCP keepalive of sockets. See socket article for more details | `false` |
| `fluentd.forward.chunkSizeLimit` | The size limit of the the received chunk. If the chunk size is larger than this value, then the received chunk is dropped | `nil` |
| `fluentd.forward.chunkSizeWarnLimit` | The warning size limit of the received chunk. If the chunk size is larger than this value, a warning message will be sent | `nil` |
| `fluentd.forward.skipInvalidEvent` | Skip an event if incoming event is invalid | `false` |
| `fluentd.forward.sourceAddressKey` | The field name of the client's source address. If set the value, the client's address will be set to its key | `nil` |
| `fluentd.forward.sourceHostnameKey` | The field name of the client's hostname. If set the value, the client's hostname will be set to its key | `nil` |
| `fluentd.forward.tls.enabled` | If true, using TLS transport | `false` |
| `fluentd.forward.tls.certPath` | Cert path to use with TLS | `""` |
| `fluentd.forward.service.enabled` | If true, use service for forward input | `false` |
| `fluentd.forward.service.annotations` | Annotations to be added to service | `{}` |
| `fluentd.forward.service.labels` | Labels to be added to service | `{}` |
| `fluentd.forward.service.port` | The service port for forward input | `"24224"` |
| `fluentd.forward.service.type` | The service type for forward input | `"ClusterIP"` |
| `affinity` | Node/Pod affinities | `{}` |
| `annotations` | Annotations to be added to daemonset or statefulset | `{}` |
| `args` | Additional arguments | `[]` |
| `command` | Additional command arguments | `[]` |
| `env` | Extra environment variables that will be passed onto pods	| `[]` |
| `extraPort` | Extra port variables that will be passed onto pods | `[]` |
| `extraVolumeMounts` | Extra volume mounts variables that will be passed onto pods	 | `[]` |
| `extraVolumes` | Extra volumes variables that will be passed onto pods	 | `[]` |
| `labels` | labels to be added to daemonset or statefulset | `{}` |
| `livenessProbe.enabled` | Enable liveness probes | `true` |
| `livenessProbe.initialDelaySeconds` | Delay before liveness probe is initiated | `60` |
| `livenessProbe.periodSeconds` | How often to perform the probe | `10` |
| `livenessProbe.timeoutSeconds` | When the probe times out | `5` |
| `livenessProbe.failureThreshold` | Minimum consecutive failures for the probe to be considered failed after having succeeded | `6` |
| `livenessProbe.successThreshold` | Minimum consecutive successes for the probe to be considered successful after having failed | `1` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `podAnnotations` | Annotations to be added to pods | `{}` |
| `podLabels` | Labels to be added to pods | `{}` |
| `podSecurityContext` | Security context policies to add to the controller pod | `{}` |
| `priorityClassName` | Priority Class Name | `""` |
| `readinessProbe.enabled` | Enable readiness probes | `true` |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated | `60` |
| `readinessProbe.periodSeconds` | How often to perform the probe | `10` |
| `readinessProbe.timeoutSeconds` | When the probe times out | `5` |
| `readinessProbe.failureThreshold` | Minimum consecutive failures for the probe to be considered failed after having succeeded | `6` |
| `readinessProbe.successThreshold` | Minimum consecutive successes for the probe to be considered successful after having failed | `1` |
| `resources` | Pod resource requests & limits | `{}` |
| `securityContext` | Allows you to overwrite the default securityContext applied to the container | `{}` |
| `terminationGracePeriodSeconds` | Termination grace period (in seconds) | `30` |
| `tolerations` | Node taints to tolerate | `[]` |
| `daemonset.enabled` | If true, enable daemonset | `true` |
| `daemonset.useHostNetwork` | If true, use the host's network	 | `false` |
| `daemonset.updateStrategy` | Which update strategy to deploy the daemonset | `"RollingUpdate"` |
| `statefulset.enabled` | If true, enable statefulset | `false` |
| `statefulset.replicas` | the number of replicas to statefulset | `1` |
| `statefulset.updateStrategy` | Which update strategy to deploy the statefulset | `"RollingUpdate"` |
| `extraService` | If service is required for inputs other than http/forward, use extraService | `[]` |
| `serviceAccount.create` | If true, create a service account for the pod | `false` |
| `serviceAccount.annotations` | Annotations for the created service account | `{}` |
| `serviceAccount.name` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `nil` |
| `persistence.enabled` | Enable Persistence for configuration | `false` |
| `persistence.annotations` | Annotations to be added to PVC | `{}` |
| `persistence.existingClaim` | Name of an existing PVC | `false` |
| `persistence.labels` | Labels to be added to PVC | `{}` |
| `persistence.accessMode` | PVC access mode | `"ReadWriteOnce"` |
| `persistence.size` | PVC storage request | `"8Gi"` |
| `persistence.storageClass:` | PVC storage class  | `nil` |
| `rbac.create` | If true, create & use RBAC resources | `false` |
| `metrics.enabled` | If true, enable Prometheus metrics | `false` |
| `metrics.port` | Listen port | `24231` |
| `metrics.bind` | Binding interface | `"0.0.0.0"` |
| `metrics.metricsPath` | Metrics HTTP endpoint | `"/metrics"` |
| `metrics.aggregatedMetricsPath` | Metrics HTTP endpoint | `/aggregated_metrics"` |
| `metrics.interval` | Interval to update monitor_agent information in seconds | `5` |
| `configmaps:` | Configuration file to be mounted under /fluentd/etc/fluent.conf and /fluentd/etc/config.d/ | `{"fluent.conf": "..."}` |
| `secrets` | Secret information file to be mounted under /secure | `{}` |
