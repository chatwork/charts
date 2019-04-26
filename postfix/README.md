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
`livenessProbe.tcpSocket.port` | tcp socket port for livenessprobe | `25`
`livenessProbe.failureThreshold` | livenessprobe failure threshold | `2`
`livenessProbe.initialDelaySeconds` | livenessprobe initial delay seconds | `10`
`livenessProbe.failureThreshold` | livenessprobe failure threshold | `2`
`livenessProbe.periodSeconds` | livenessprobe period seconds | `60`
`readinessProbe.tcpSocket.port` | tcp socket port for readinessprobe | `25`
`readinessprobe.failureThreshold` | readinessprobe failure threshold | `2`
`readinessprobe.initialDelaySeconds` | readinessprobe initial delay seconds | `10`
`readinessprobe.failureThreshold` | readinessprobe failure threshold | `2`
`readinessprobe.periodSeconds` | readinessprobe period seconds | `60`
`resource` | container ressource(cpu, memory) | `{}`
`extraVolumeMounts` | extra volumes mount for container | `[]`
`extraVolumes` | extra volumes for container | `[]`
`daemonset.enabled` | Enable daemonset  | `true`
`daemonset.useHostNetwork` | Use hostNetwork | `true`
`daemonset.useHostPort` | Use hostPort(port 25) | `true`
