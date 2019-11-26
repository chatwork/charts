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
|  `volumeMounts.data` | VolumeMounts path for data directory | `"/var/lib/twistlock"` |
|  `volumeMounts.certificates` | VolumeMounts path for certificates(secrets) | `"/var/lib/twistlock/certificates"` |
|  `volumeMounts.docker.sockPath` | VolumeMounts path for docker sock root path | `"/var/run"` |
|  `volumeMounts.docker.netns` | VolumeMounts path for docker netns(network namespace) | `"/var/run/docker/netns"` |
|  `volumeMounts.iptablesFlockPath` | VolumeMounts path for iptables | `"/run"` |
|  `volumes.data` | Host Path for data volume  | `"/var/lib/twistlock/defender"` |
|  `volumes.docker.sockPath` | Host Path for docker sock root  | `"/var/run"` |
|  `volumes.docker.netns` | Host Path for docker netns | `"/var/run/docker/netns"` |
|  `volumes.iptablesFlockPath` | Host Path for iptables | `"/run"` |
|  `volumes.passwd` | Host Path for passwd | `"/etc/passwd"` |
|  `volumes.auditlog` | Host Path for auditd path | `"/var/log/audit"` |
|  `volumes.syslog` | Host Path for syslog | `"/dev/log"` |
|  `config.console.wsAddress` | Configuration twistlock-console web socket address | `"wss://{{ .Values.console.dnsName }}:{{ .Values.console.port }}"` |
|  `config.defender.type` | Configuration defender type | `"daemonset"` |
|  `config.defender.listenerType` | Configuration defender listener type | `"none"` |
|  `config.clusterId` | Configuration defender clusterId which generate by console | `"CLUSTERID"` |
|  `config.monitor.serviceAccounts` | Configuration monitor service accounts | `"true"` |
|  `config.monitor.istio` | Configuration monitor istio | `"false"` |
|  `config.installBundle` | Configuration installBundle for rasp | `""` |
|  `config.docker.clientAddress` | Configuration docker client address path | `"/var/run/docker.sock"` |
|  `config.docker.tag` | Configuration docker tag for image | `"_19_07_363"` |
|  `resources.limit.cpu` | Resources cpu limit | `"1000m"` |
|  `resources.limit.memory` | Resources memory limit | `"512Mi"` |
|  `resources.requests.cpu` | Resources cpu requests | `"250m"` |
|  `resources.requests.memory` | Resources memory limit | `"256Mi"` |
|  `securityContext.readOnlyRootFileSystem` | Security Context for read only root | `"true"` |
|  `securityContext.privileged` | Security Context for read privileged | `"true"` |
|  `securityContext.capabilities.add` | Security Context for capabilities | `"[NET_ADMIN, SYS_ADMIN, SYS_PTRACE, AUDIT_CONTROL]"` |
|  `secret.ca_cert` | ca cert for defender | `"CA_CERT"` |
|  `secret.client_cert` | client cert for defender | `"CLIENT_CERT"` |
|  `secret.client_key` | client key for defender | `"CLIENT_KEY"` |
|  `secret.service_parameter` | service parameter which genrated by console for defender | `"SERVICE_PARAMETER"` |
|  `useHostNetwork` | Pod using hostNetwork | `true`|
|  `useHostPID` | Pod using hostPID | `true`|
|  `deployment.enabled` | Enable defender deployment | `false`|
|  `deployment.annotations` | Deployment annotations | `"{}"`|
|  `deployment.replicas` | Deployment replicas | `1`|
|  `deployment.strategy` | Deployment update strategy | `"{}"`|
|  `daemonset.enabled` | Enable defender daemonset| `true`|
|  `daemonset.annotations` | Damonset annotations | `"{}"`|
|  `daemonset.updateStrategy` | Daemonset update strategy | `"{}"`|
|  `podAnnotations` | Pod annotations | `{}`|
|  `tolerations` | Pod tolerations | `[]`|
|  `extraEnv` | Pod extra environment value | `[]`|
|  `extraVolumeMounts` | Pod extra volumeMounts | `[]`|
|  `extraVolume` | Pod extra volume | `[]`|
