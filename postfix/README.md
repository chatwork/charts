
Postfix
===========

Postfix Helm Chart

## TL;DR;

```
$ helm install chatwork/postfix
```

## Prerequisites

* Kubernetes 1.16+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install my-release chatwork/postfix
```

The command deploys the postfix on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/postfix#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Configuration

The following table lists the configurable parameters of the Postfix chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `image.repository` | The image repository to pull from | `"chatwork/postfix"` |
| `image.tag` | The image tag to pull | `"3.6.3"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
| `nameOverride` | Override name of app | `""` |
| `fullnameOverride` | Override full name of app | `""` |
| `terminationGracePeriodSeconds` | Termination grace period (in seconds) | `60` |
| `containerPort` | container port | `25` |
| `livenessProbe.initialDelaySeconds` | Delay before liveness probe is initiated | `10` |
| `livenessProbe.periodSeconds` | How often to perform the probe | `30` |
| `livenessProbe.timeoutSeconds` | When the probe times out | `5` |
| `livenessProbe.successThreshold` | Minimum number of consecutive successes for a probe to be considered successful after a probe has failed | `1` |
| `livenessProbe.failureThreshold` | Minimum number of consecutive successes for the probe to be considered successful after having failed | `2` |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated | `30` |
| `readinessProbe.periodSeconds` | How often to perform the probe | `30` |
| `readinessProbe.timeoutSeconds` | When the probe times out | `5` |
| `readinessProbe.successThreshold` | Minimum number of consecutive successes for a probe to be considered successful after a probe has failed | `1` |
| `readinessProbe.failureThreshold` | Minimum number of consecutive successes for the probe to be considered successful after having failed | `2` |
| `persistence.enabled` | if true, application use persistent volume | `false` |
| `persistence.accessMode` | persistent volume access mode| `"ReadWriteOnce"` |
| `persistence.size` | persistent volume size| `"8Gi"` |
| `persistence.annotations` | persistent volume annotations | `{}` |
| `priorityClassName` | primaryClassName | `""` |
| `resources` | resources | `{}` |
| `extraVolumeMounts` | extra VolumeMounts | `[]` |
| `extraVolumes` | extra VolumeMounts | `[]` |
| `daemonset.enabled` | if true, postfix deployed as daemonset | `true` |
| `daemonset.annotations` | daemonset annotations  | `{}` |
| `daemonset.useHostNetwork` | if true, postfix daemonset use hostNetwork | `false` |
| `daemonset.hostPort` | If you enter a value, hostPort is enabled and the value is set. | `25` |
| `daemonset.lifecycle.preStop.exec.command` | postfix preStop command | `["/usr/sbin/postfix", "flush"]` |
| `daemonset.podAnnotations` | daemonset Pod annotations | `{}` |
| `daemonset.affinity` | daemonset affinity | `{}` |
| `daemonset.tolerations` | daemonset tolerations | `[]` |
| `daemonset.updateStrategy.type` | daemonset updateStrategy type | `"RollingUpdate"` |
| `daemonset.updateStrategy.rollingUpdate.maxUnavailable` | daemonset update strategy max unavailable pod | `1` |
| `deployment.annotations` | deployment annotations | `{}` |
| `deployment.enabled` | If true, postfix deployed as deployment | `false` |
| `deployment.replicaCount` | deployment replicaCount | `1` |
| `deployment.strategy` | Specifies the strategy used to replace old pods by new ones | `{}` |
| `deployment.lifecycle.preStop.exec.command` | deployment prestop command | `["/usr/sbin/postfix", "flush"]` |
| `deployment.podAnnotations` | deployment pod annotations  | `{}` |
| `deployment.affinity` | deployment affinity | `{}` |
| `deployment.tolerations` | deployment tolerations | `[]` |
| `deployment.podDisruptionBudget.enabled` | if true, create deployment pod disruption budget | `false` |
| `deployment.podDisruptionBudget.minAvailable` | Deployment minimum number / percentage of pods that should remain scheduled | `1` |
| `deployment.podDisruptionBudget.maxUnavailable` | Deployment maximum number / percentage of pods that should remain scheduled  | `null` |
| `statefulSet.enabled` | if true, postfix deployed as statefulSet | `false` |
| `statefulSet.annotations` | statefulset annotations | `{}` |
| `statefulSet.replicas` | statefulset replicas  | `1` |
| `statefulSet.podManagementPolicy` | statefulset allows you to relax its ordering guarantees while preserving its uniqueness and identity guarantees  | `Parallel` |
| `statefulSet.lifecycle.preStop.exec.command` | statefulset preStop command  | `["/usr/sbin/postfix", "flush"]` |
| `statefulSet.podAnnotations` | statefulset pod annotations | `{}` |
| `statefulSet.affinity` | statefulset affinity | `{}` |
| `statefulSet.tolerations` | statefulset tolerations | `[]` |
| `statefulSet.updateStrategy` | statefulset updateStrategy | `"RollingUpdate"` |
| `service.type` | service type | `"ClusterIP"` |
| `service.port` | service port | `25` |
| `service.annotations` | service annotations | `{}` |
| `postfix.templates.main.cf` | postfix's config file `main.cf ` template  |-- |
| `postfix.secrets` | application secret | `{}` |
| `metrics.enabled` | if true, prometheus exporter is deployed with sidecar | `false` |
| `metrics.image.repository` | metrics container image repository | `"chatwork/kumina-postfix-exporter"` |
| `metrics.image.tag` | metrics container image tag | `"k-kinzal-fixes-panic-logfilepath-empty"` |
| `metrics.image.pullPolicy` | metrics container image pullPolicy` | `"IfNotPresent"` |
| `metrics.command` | metrics container command | `["/bin/postfix_exporter", "--postfix.logfile_path=\"\""]` |
| `metrics.port` | metrics container port | `9154` |
| `metrics.resources` | metrics container resources | `{}` |
| `metrics.livenessProbe` | metrics container livenessProbe | `{}` |
| `metrics.readinessProbe` | metrics container readinessProbe | `{}` |
| `test.toEmail` | test application email to | `"a@example.com"` |
| `mailcatcher.enabled` | if true, mailcatcher deployed for test | `false` |
| `mailcatcher.image.repository` | mailcatcher image repository | `"chatwork/mailcatcher"` |
| `mailcatcher.image.tag` | mailcatcher image tag | `"latest"` |
| `mailcatcher.image.pullPolicy` | mailcatcher image pullPolicy  | `"IfNotPresent"` |
| `mailcatcher.livenessProbe.httpGet.port` | mailcatcher livenessProbe specify the port to check the liveness probe with http | `1080` |
| `mailcatcher.livenessProbe.httpGet.path` | mailcatcher livenessProbe specify the endpoint to check the liveness probe with http | `"/"` |
| `mailcatcher.livenessProbe.httpGet.scheme` | mailcatcher livenessProbe specify the scheme to check the liveness probe with http | `"HTTP"` |
| `mailcatcher.livenessProbe.failureThreshold` | mailcatcher livenessProbe failureThreshold  | `2` |
| `mailcatcher.livenessProbe.initialDelaySeconds` | mailcatcher livenessProbe initialDelaySeconds| `10` |
| `mailcatcher.livenessProbe.periodSeconds` | mailcatcher livenessProbe periodSeconds| `60` |
| `mailcatcher.readinessProbe.httpGet.port` | mailcatcher readinessProbe specify the port to check the readiness probe with http| `1080` |
| `mailcatcher.readinessProbe.httpGet.path` | mailcatcher readinessProbe specify the path to check the readiness probe with http| `"/"` |
| `mailcatcher.readinessProbe.httpGet.scheme` | mailcatcher readinessProbe specify the scheme to check the readiness probe with http| `"HTTP"` |
| `mailcatcher.readinessProbe.failureThreshold` | mailcatcher readinessProbe failureThreshold| `2` |
| `mailcatcher.readinessProbe.periodSeconds` | mailcatcher readinessProbe periodSeconds| `5` |
| `mailcatcher.service.type` | mailcatcher service type| `"LoadBalancer"` |
| `mailcatcher.service.httpPort` | mailcatcher service httpPort| `1080` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

