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

## If you set tls with cert-manager

You can use cert-manager to create a selfSigned issuer to create a CA and ca issuer for creating the required certs using that CA (note the following is only compatible with cert-manager version 1.5.4 or later):

### cert-manager manifests

```
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: selfsigned-issuer
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: fluentd-ca
  labels:
    release: fluent
spec:
  secretName: fluent-ca-tls
  commonName: "fluent-ca-tls"
  isCA: true
  privateKey:
    algorithm: ECDSA
    size: 256
  issuerRef:
    name: selfsigned-issuer
    kind: ClusterIssuer
    group: cert-manager.io
---
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: fluent-issuer
  labels:
    release: fluent
spec:
  ca:
    secretName: fluent-ca-tls
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: fluentd-cert
  labels:
    release: fluentd
spec:
  dnsNames:
  - fluentd-forward
  - fluentd-forward.{{ .Release.Namespace }}.svc
  - fluentd-forward.{{ .Release.Namespace }}.svc.cluster.local
  issuerRef:
    kind: Issuer
    name: fluent-issuer
  secretName: fluentd-forward-tls
```

You need mount secret for tls and set parameter transport section:

```
extraVolumeMounts:
  - name: fluentd-forward-tls
    # You can use any path
    mountPath: /fluentd/forward/tls

extraVolumes:
  - name: fluentd-forward-tls
    secret:
      secretName: fluentd-forward-tls

fluentd:
  forward:
    tls:
      enabled: {{ .Values.fluentd.tls.enabled }}
      config:
        version: TLSv1_3
        caPath: /fluentd/forward/tls/ca.crt
        certPath: /fluentd/forward/tls/tls.crt
        privateKeyPath: /fluentd/forward/tls/tls.key
```

If you use fluent-bit by node log collector, this[https://banzaicloud.com/blog/k8s-logging-tls/] is helpful.

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
| `fluentd.http.tls.config.version` | TLS version | `""` |
| `fluentd.http.tls.config.minVersion` | Specifies the lower bound of the supported SSL/TLS protocol. | `""` |
| `fluentd.http.tls.config.maxVersion` | Specifies the upper bound of the supported SSL/TLS protocol. | `""` |
| `fluentd.http.tls.config.ciphers` | CipherSuite | `""` |
| `fluentd.http.tls.config.insecure` | TLS insecure  | `""` |
| `fluentd.http.tls.config.caPath` | Specifies the path of CA certificate file | `""` |
| `fluentd.http.tls.config.certPath` | Specifies the path of Certificate file | `""` |
| `fluentd.http.tls.config.privateKeyPath` | Specifies the path of Private Key file  | `""` |
| `fluentd.http.tls.config.privateKeyPassphrase` | Specifies the public CA private key passphrase | `""` |
| `fluentd.http.tls.config.clientCertAuth` | If true, Fluentd will check all the incoming HTTPS requests for aclient certificate signed by the trusted CA. The requests that don'tsupply a valid client certificate will fail. | `""` |
| `fluentd.http.tls.config.certVerifier` | Specifies the code path for cert verification  | `""` |
| `fluentd.http.tls.config.caCertPath` | Specifies the private CA cert path  | `""` |
| `fluentd.http.tls.config.caPrivateKeyPath` | Specifies the private CA private key path  | `""` |
| `fluentd.http.tls.config.caPrivateKeyPassphrase` | Specifies the private CA private key passphrase | `""` |
| `fluentd.http.tls.config.generatePrivateKeyLength` | Specifies the generated private key length  | `""` |
| `fluentd.http.tls.config.generateCertCountry` | Specifies the generated cerification country | `""` |
| `fluentd.http.tls.config.generateCertState` | Specifies the generated cerification state  | `""` |
| `fluentd.http.tls.config.generateCertLocality` | Specifies the generated cerification locallity  | `""` |
| `fluentd.http.tls.config.generateCertCommonName` | Specifies the generated cerification common name | `""` |
| `fluentd.http.tls.config.generateCertExpiration` | Specifies the generated cerification expiration | `""` |
| `fluentd.http.tls.config.generateCertDigest` | Specifies the generated cerification digest | `""` |
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
| `fluentd.forward.tls.config.version` | TLS version | `""` |
| `fluentd.forward.tls.config.minVersion` | Specifies the lower bound of the supported SSL/TLS protocol. | `""` |
| `fluentd.forward.tls.config.maxVersion` | Specifies the upper bound of the supported SSL/TLS protocol. | `""` |
| `fluentd.forward.tls.config.ciphers` | CipherSuite | `""` |
| `fluentd.forward.tls.config.insecure` | TLS insecure  | `""` |
| `fluentd.forward.tls.config.caPath` | Specifies the path of CA certificate file | `""` |
| `fluentd.forward.tls.config.certPath` | Specifies the path of Certificate file | `""` |
| `fluentd.forward.tls.config.privateKeyPath` | Specifies the path of Private Key file  | `""` |
| `fluentd.forward.tls.config.privateKeyPassphrase` | Specifies the public CA private key passphrase | `""` |
| `fluentd.forward.tls.config.clientCertAuth` | If true, Fluentd will check all the incoming forwardS requests for aclient certificate signed by the trusted CA. The requests that don'tsupply a valid client certificate will fail. | `""` |
| `fluentd.forward.tls.config.certVerifier` | Specifies the code path for cert verification  | `""` |
| `fluentd.forward.tls.config.caCertPath` | Specifies the private CA cert path  | `""` |
| `fluentd.forward.tls.config.caPrivateKeyPath` | Specifies the private CA private key path  | `""` |
| `fluentd.forward.tls.config.caPrivateKeyPassphrase` | Specifies the private CA private key passphrase | `""` |
| `fluentd.forward.tls.config.generatePrivateKeyLength` | Specifies the generated private key length  | `""` |
| `fluentd.forward.tls.config.generateCertCountry` | Specifies the generated cerification country | `""` |
| `fluentd.forward.tls.config.generateCertState` | Specifies the generated cerification state  | `""` |
| `fluentd.forward.tls.config.generateCertLocality` | Specifies the generated cerification locallity  | `""` |
| `fluentd.forward.tls.config.generateCertCommonName` | Specifies the generated cerification common name | `""` |
| `fluentd.forward.tls.config.generateCertExpiration` | Specifies the generated cerification expiration | `""` |
| `fluentd.forward.tls.config.generateCertDigest` | Specifies the generated cerification digest | `""` |
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
