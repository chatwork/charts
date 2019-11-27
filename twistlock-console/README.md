## twistlock-console

This chart for twistlock-console https://www.twistlock.com/

## TL;DR;

You need follow parameters.

- accessToken
  - payout from twistlock

```
$ helm install --name twistlock-console --namespace twistlock --set accessToken="XXX" chatwork/twistlock-defender
```

## Prerequisites

* Kubernetes 1.11+

# Uninstalling the Chart

```
$ helm delete twistlock-console
```

## Configuration

The following table lists the configurable parameters of the gaurd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `accessToken` | Payout from twistlock | `"accessToken"` |
|  `image.imagePullSecrets` | Image imagePullSecrets | `"[]"` |
|  `image.repository` | Defender image repository | `"registry-auth.twistlock.com/tw_{{ .Values.accessToken }}/twistlock/defender"` |
|  `image.tag` | Defender image tag | `"defender{{ .Values.config.docker.tag }}"` |
|  `image.imagePullPolicy` | Image pullpolicy  | `"IfNotPresent"` |
|  `port.communication` | Console <-> Defener commutation port  | `"8084"` |
|  `port.management.http` | Console management http port  | `"8081"` |
|  `port.management.https` | Console management https port  | `"8083"` |
|  `port.highAvailability` | Console high availability port  | `"8086"` |
|  `volumeMounts.data.mountPath` | VolumeMounts path for data directory | `"/var/lib/twistlock"` |
|  `volumeMounts.data.subPath` | VolumeMounts subPath for data directory | `"twistlock"` |
|  `volumeMounts.backup.mountPath` | VolumeMounts path for backup directory | `"/var/lib/twistlock-backup"` |
|  `volumeMounts.backup.subPath` | VolumeMounts subPath for backup directory | `"twistlock-backup"` |
|  `config.console.cn` | Configuration console common name | `""` |
|  `config.console.san` | Configuration console subject alternative name | `""` |
|  `config.console.portalServer.cert` | Configuration console https custom cert | `""` |
|  `config.console.portalServer.key` | Configuration console https custom key| `""` |
|  `config.defender.cn` | Configuration defender common name | `""` |
|  `config.defender.listenerType` | Configuration defender listener type| `"none"` |
|  `config.readOnlyFs` | Sets Twistlock containers' file-systems to read-only | `true` |
|  `config.runConsoleAsRoot` | Run Twistlock Console processes as root (default, twistlock user account) | `false` |
|  `config.docker.tag` | docker image tag| `"_19_07_363"` |
|  `config.docker.socket` | docker socket path| `"/var/run/docker.sock"` |
|  `config.backup` | Enable backup (but same volume) | `"true"` |
|  `config.management.http.enabled` | Enable management http | `"false"` |
|  `config.highAvailability.enabled` | Enable console high availability | `"false"` |
|  `config.highAvailability.state` | Console high availability state | `"PRIMARY"` |
|  `config.scap.enabled` | Enable console scap | `"false"` |
|  `config.selinux.label` | Configure selinux label | `"disable"` |
|  `resources.limit.cpu` | Resources cpu limit | `"500m"` |
|  `resources.limit.memory` | Resources memory limit | `"1024Mi"` |
|  `resources.requests.cpu` | Resources cpu requests | `"250m"` |
|  `resources.requests.memory` | Resources memory limit | `"1024Mi"` |
|  `deployment.annotations` | Deployment annotations | `"{}"`|
|  `deployment.replicas` | Deployment replicas | `1`|
|  `deployment.strategy` | Deployment update strategy | `"{}"`|
|  `podAnnotations` | Pod annotations | `{}`|
|  `tolerations` | Pod tolerations | `[]`|
|  `livenessProve` | Pod livenessProve | `tcpSocket.port: {{ .Values.port.management.https }}`|
|  `readinessProve` | Pod readinessProve | `tcpSocket.port: {{ .Values.port.management.https }}`|
|  `extraEnv` | Pod extra environment value | `[]`|
|  `extraVolumeMounts` | Pod extra volumeMounts | `[]`|
|  `extraVolume` | Pod extra volume | `[]`|
|  `persistenceVolumeClaim.storage.size` | PVC volume size | `"100G"` |
|  `persistenceVolumeClaim.storage.className` | PVC volume class name| `"gp2"` |
|  `persistenceVolumeClaim.selector` | PVC selector | `"{}"` |
|  `service.clusterIP` | Set service cluster ip | `""` |
|  `service.type` | Set service type | `"LoadBalancer"` |
|  `secrets` | Configuration secrets value | `"{}"` |
|  `configmap.twistlock.cfg` | Configuration twistlock console using configmap | `"..."`|
