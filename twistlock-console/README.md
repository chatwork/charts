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
|  `port.communication.containerPort` | Console <-> Defener commutation port for container | `"8084"` |
|  `port.communication.servicePort` | Console <-> Defener commutation port for service | `"8084"` |
|  `port.management.http.containerPort` | Console management http port for container | `"8081"` |
|  `port.management.http.servicePort` | Console management http port for service| `"8081"` |
|  `port.management.https.containerPort` | Console management https port for container| `"8083"` |
|  `port.management.https.servicePort` | Console management https port for service | `"8083"` |
|  `volumeMounts.data.mountPath` | VolumeMounts path for data directory | `"/var/lib/twistlock"` |
|  `volumeMounts.data.subPath` | VolumeMounts subPath for data directory | `"twistlock"` |
|  `volumeMounts.backup.mountPath` | VolumeMounts path for backup directory | `"/var/lib/twistlock-backup"` |
|  `volumeMounts.backup.subPath` | VolumeMounts subPath for backup directory | `"twistlock-backup"` |
|  `config.console.cn` | Configuration console common name | `""` |
|  `config.console.portalServer.cert` | Configuration console https custom cert | `""` |
|  `config.console.portalServer.key` | Configuration console https custom key| `""` |
|  `config.defender.cn` | Configuration defender common name | `""` |
|  `config.defender.listenerType` | Configuration defender listener type| `"none"` |
|  `config.readOnlyFs` | Sets Twistlock containers' file-systems to read-only | `true` |
|  `config.runConsoleAsRoot` | Run Twistlock Console processes as root (default, twistlock user account) | `false` |
|  `config.docker.tag` | docker image tag| `"_20_09_365"` |
|  `config.docker.socket` | docker socket path| `"/var/run/docker.sock"` |
|  `config.backup` | Enable backup (but same volume) | `"true"` |
|  `config.management.http.enabled` | Enable management http | `"false"` |
|  `config.scap.enabled` | Enable console scap | `"false"` |
|  `config.selinux.label` | Configure selinux label | `"disable"` |
|  `resources.limit.cpu` | Resources cpu limit | `"500m"` |
|  `resources.limit.memory` | Resources memory limit | `"1024Mi"` |
|  `resources.requests.cpu` | Resources cpu requests | `"250m"` |
|  `resources.requests.memory` | Resources memory limit | `"1024Mi"` |
|  `annotations` | Deployment annotations | `"{}"`|
|  `replicas` | Deployment replicas | `1`|
|  `strategy` | Deployment update strategy | `"{}"`|
|  `podAnnotations` | Pod annotations | `{}`|
|  `tolerations` | Pod tolerations | `[]`|
|  `livenessProve` | Pod livenessProve | `...`|
|  `readinessProve` | Pod readinessProve | `...` |
|  `extraEnv` | Pod extra environment value | `[]`|
|  `extraVolumeMounts` | Pod extra volumeMounts | `[]`|
|  `extraVolume` | Pod extra volume | `[]`|
|  `priorityClassName` | Pod priority class name | `""`|
|  `persistenceVolumeClaim.storage.size` | PVC volume size | `"100G"` |
|  `persistenceVolumeClaim.storage.className` | PVC volume class name| `"gp2"` |
|  `persistenceVolumeClaim.selector` | PVC selector | `"{}"` |
|  `service.clusterIP` | Set service cluster ip | `""` |
|  `service.type` | Set service type | `"LoadBalancer"` |
|  `secrets` | Configuration secrets value | `"{}"` |
|  `configmap.twistlock.cfg` | Configuration twistlock console using configmap | `"..."`|
