## twistlock-defender

This chart for twistlock-defender https://www.twistlock.com/
twistlock-defender is agent per node.

## TL;DR;

You need follow parameters.

- accessToken
  - payout from twistlock
- config.clusterId
  - generate by twistcli export
- secret.ca_cert
  - generate by twistcli export
- secret.client_cert
  - generate by twistcli export
- secret.client_key
  - generate by twistcli export
- secret.service_parameter
  - generate by twistcli export

The above parameters are difficult to specify with set option, so please write to file(ex. settings.yaml).

```
$ helm install -f settings.yaml --name twistlock-defender --namespace twistlock chatwork/twistlock-defender
```

## Prerequisites

* Kubernetes 1.11+

# Uninstalling the Chart

```
$ helm delete twistlock-defender
```

## Configuration

The following table lists the configurable parameters of the gaurd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `accessToken` | Payout from twistlock | `"accessToken"` |
|  `console.dnsName` | Console dnsName for communicate with defender | `"twistlock-console" `|
|  `console.port` | Console port for communicate with defender | `"8084" `|
|  `image.imagePullSecrets` | Image imagePullSecrets | `"[]"` |
|  `image.repository` | Defender image repository | `"registry-auth.twistlock.com/tw_{{ .Values.accessToken }}/twistlock/defender"` |
|  `image.tag` | Defender image tag | `"defender{{ .Values.config.docker.tag }}"` |
|  `image.imagePullPolicy` | Image pullpolicy  | `"IfNotPresent"` |
|  `volumeMounts.dataPath` | VolumeMounts path for data directory | `"/var/lib/twistlock"` |
|  `volumeMounts.certificates` | VolumeMounts path for certificates(secrets) | `"/var/lib/twistlock/certificates"` |
|  `volumeMounts.docker.sockPath` | VolumeMounts path for docker sock root path | `"/var/run"` |
|  `volumes.dataPath` | Host Path for data volume  | `"/var/lib/twistlock/defender"` |
|  `volumes.docker.sockPath` | Host Path for docker sock root  | `"/var/run"` |
|  `volumes.passwd` | Host Path for passwd | `"/etc/passwd"` |
|  `volumes.auditlog` | Host Path for auditd path | `"/var/log/audit"` |
|  `volumes.syslog` | Host Path for syslog | `"/dev/log"` |
|  `config.console.wsAddress` | Configuration twistlock-console web socket address | `"wss://{{ .Values.console.dnsName }}:{{ .Values.console.port }}"` |
|  `config.defender.type` | Configuration defender type | `"cri"` |
|  `config.defender.listenerType` | Configuration defender listener type | `"none"` |
|  `config.clusterId` | Configuration defender clusterId which generate by console | `"CLUSTERID"` |
|  `config.monitor.serviceAccounts` | Configuration monitor service accounts | `true` |
|  `config.monitor.istio` | Configuration monitor istio | `"false"` |
|  `config.installBundle` | Configuration installBundle for rasp | `""` |
|  `config.cloudHostnameEnabled` | Configuration cloudHostnameEnabled | `"false"` |
|  `config.docker.clientAddress` | Configuration docker client address path | `"/var/run/docker.sock"` |
|  `config.docker.tag` | Configuration docker tag for image | `"_22_01_882"` |
|  `config.collectPodLabels` | Configuration collect pod labels | `true` |
|  `resources.limit.cpu` | Resources cpu limit | `"1000m"` |
|  `resources.limit.memory` | Resources memory limit | `"512Mi"` |
|  `resources.requests.cpu` | Resources cpu requests | `"250m"` |
|  `resources.requests.memory` | Resources memory limit | `"256Mi"` |
|  `securityContext.readOnlyRootFileSystem` | Security Context for read only root | `"true"` |
|  `securityContext.privileged` | Security Context for read privileged | `"true"` |
|  `securityContext.capabilities.add` | Security Context for capabilities | `"[NET_ADMIN, NET_RAW, SYS_ADMIN, SYS_PTRACE, SYS_CHROOT, MKNOD, SETFCAP, IPC_LOCK]"` |
|  `secret.ca_cert` | ca cert for defender | `"CA_CERT"` |
|  `secret.client_cert` | client cert for defender | `"CLIENT_CERT"` |
|  `secret.client_key` | client key for defender | `"CLIENT_KEY"` |
|  `secret.service_parameter` | service parameter which genrated by console for defender | `"SERVICE_PARAMETER"` |
|  `secret.admission_cert` | admission cert for defender | `nil` |
|  `secret.admission_key` | admission key for defender | `nil` |
|  `useHostNetwork` | Pod using hostNetwork | `true`|
|  `useHostPID` | Pod using hostPID | `true`|
|  `annotations` | Damonset annotations | `"{}"`|
|  `updateStrategy` | Daemonset update strategy | `"{}"`|
|  `podAnnotations` | Pod annotations | `{}`|
|  `tolerations` | Pod tolerations | `[]`|
|  `extraEnv` | Pod extra environment value | `[]`|
|  `extraVolumeMounts` | Pod extra volumeMounts | `[]`|
|  `extraVolume` | Pod extra volume | `[]`|
|  `livenessProve` | Pod livenessProve | `{}`|
|  `readinessProve` | Pod readinessProve | `{}`|
|  `priorityClassName` | Pod priority class name | `""`|
