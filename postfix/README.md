# Postfix

[Postfix](http://www.postfix.org/) is mail server application.

# Prerequisites

Kubernetes 1.11+

# All configuration options

Parameter | Description | Default
--- | --- | ---
`image.repository` | Image repository | `chatwork/postfix`
`image.tag` | Image tag | `latest`
`image.pullPolicy` | Image Pull Policy | `IfNotPresent`
`nameOverride` | Override name of app | `""`
`fullnameOverride` | Override fullname of app  | `""`
`terminationGracePeriodSeconds` | Termination graceful period seconds for app | `60`
`livenessProbe.tcpSocket.port` | TCP socket port for livenessprobe | `25`
`livenessProbe.failureThreshold` | livenessprobe failure threshold | `2`
`livenessProbe.initialDelaySeconds` | livenessprobe initial delay seconds | `10`
`livenessProbe.failureThreshold` | livenessprobe failure threshold | `2`
`livenessProbe.periodSeconds` | livenessprobe period seconds | `60`
`readinessProbe.tcpSocket.port` | TCP socket port for readinessprobe | `25`
`readinessprobe.failureThreshold` | readinessprobe failure threshold | `2`
`readinessprobe.initialDelaySeconds` | readinessprobe initial delay seconds | `10`
`readinessprobe.failureThreshold` | readinessprobe failure threshold | `2`
`readinessprobe.periodSeconds` | readinessprobe period seconds | `60`
`resource` | Container ressource(cpu, memory) | `{}`
`extraVolumeMounts` | Extra volumes mount for container | `[]`
`extraVolumes` | Extra volumes for container | `[]`
`daemonset.enabled` | Enable daemonset  | `true`
`daemonset.useHostNetwork` | Use hostNetwork | `false`
`daemonset.useHostPort` | Use hostPort(port 25) | `true`
`daemonset.podAnnotations` | Pod annotations | `{}`
`daemonset.affinity` | Pod affinity | `{}`
`daemonset.tolerations` | Pod tolerations | `[]`
`daemonset.updateStrategy` | Pod update strategy | `RollingUpdate`
`deployment.enabled` | Enable deployment | `false`
`deployment.replicaCount` | Deployment replica count | `2`
`deployment.service.type` | Deployment service type | `LoadBalancer`
`deployment.service.port` | Deployment service port | `25`
`deployment.strategy.type` | Deployment strategy replace pod | `RollingUpdate`
`deployment.strategy.rollingUpdate.maxSurge` | Deployment strategy maxSurge when rollingupdate | `1`
`deployment.stragegy.rollingUpdate.maxUnavailable` | Deployment strategy maxUnavailable when rollingUpdate | `0`
`deployment.podAnnotations` | Deployment pod annotations | `{}`
`deployment.affinity` | Deployment pod affinity | `{}`
`deployment.tolerations` | Deployment tolerations | `[]`
`deployment.podDisruptionBudget.enabled` | Enable pod disruption budget for deployment| `false`
`deployment.podDisruptionBudget.minAvailable` | Pod disruption budget min available pod | `1`
`deployment.podDisruptionBudget.maxUnavailable` | Pod disruption budget max unavailable pod | `1`
`postfix.templates.main_cf` | Postfix main.cf template | `...`
`postfix.secrets.sasl_passwd` | Postfix smtp password | `...`
`test.toEmail` | Email address for helm test | `a@example.com`
`mailcatcher.enabled` | Enable mailcatcher for test | `false`
`mailcatcher.image.repository` | Image repository mailcatcher | `chatwork/mailcatcher`
`mailcatcher.image.tag` | Image tag mailcatcher | `latest`
`mailcatcher.image.pullPolicy` | Image pullPolicy mailcatcher | `IfNotPresent`
`mailcatcher.service.type` | Service type for mailcatcher | `LoadBalancer`
`mailcatcher.service.httpPort` | Service port for mailcatcher | `1080`

