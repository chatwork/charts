# PHP

![image](https://user-images.githubusercontent.com/7764002/52184551-166d3680-2858-11e9-8824-5ecd3b11efcc.png)

PHP is a chart for creating PHP web applications.

## TL;DR;

```
$ helm install chatwork/php
```

## Prerequisites

* Kubernetes 1.11+
* LoadBalancer support or Ingress Controller

## Installing the Chart


To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/php
```

The command deploys the PHP chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/php#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the PHP chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `sharedPath` | Path shared by busybox/nginx/fpm | `/var/www/html` |
|  `replicaCount` | Number of pods to start with deployment | `1` |
|  `strategy` | Update strategy of pod in deployment | `type`: `RollingUpdate` |
|  `podAnnotation` | Annotation specified for pod in deployment | `{}` |
|  `imagePullSecrets` | Name of Secret resource containing private registry credentials | `[]` |
|  `restartPolicy` | Container restart policy | `""` |
|  `securityContext` | Enable security context | `""` |
|  `serviceAccountName` | Existing ServiceAccount to use | `""` |
|  `extraVolumes` | Additional volumes to all container | `[]` |
|  `extraVolumeMounts` | Additional volumeMounts to all container | `[]` |
|  `terminationGracePeriodSeconds` | Termination grace period (in seconds) | `nil` |
|  `tolerations` | Pod taint tolerations for deployment | `[]` |
|  `affinity` | Node / Pod affinities | `{}` |
|  `service.type` | Changes to ClusterIP automatically if ingress enabled | `LoadBalancer` |
|  `service.port` | Port to advertise the main web service in LoadBalancer mode | `nil` |
|  `service.extraPorts` | Additional ports | `[]` |
|  `ingress.enabled` | Enables Ingress | `false` |
|  `ingress.annotation` | Ingress annotations | `{}` |
|  `ingress.hosts` | Ingress accepted hostname | `[]` |
|  `ingress.preferPaths` | Paths that takes precedence over the ingress.path | `nil` |
|  `ingress.tls` | TLS Secret (certificates)  | `false` |
|  `podDisruptionBudget.enabled` | If true, create a pod disruption budget for keeper pods | `false` |
|  `podDisruptionBudget.minAvailabled` | Minimum number / percentage of pods that should remain scheduled | `nil` |
|  `podDisruptionBudget.maxAvailabled` | Minimum number / percentage of pods that should remain scheduled | `nil` |
|  `extras.templates` | Additional raw Kubernetes resources | `{}` |
|  `test.enabled` | Enables helm test | `true` |

### Init Containers

Initialize using busybox.
By default, we use [busybox](https://hub.docker.com/_/busybox), but you can use your container.
We recommend that you embed the source code in your container and copy it to the container of PHP and NGINX in the initialization process.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `busybox.enabled` | Enables initial containers and share volume with busybox | `true` |
|  `busybox.image.repository` | The image repository to pull from | `busybox` |
|  `busybox.image.tag` | The image tag to pull | `latest` |
|  `busybox,image.pullPolicy` | Image pull policy | `IfNotPresent` |
|  `busybox.command` | Initialize command | `["sh", "-c", "echo '<?php phpinfo();' > /var/www/html/index.php"]` |
|  `busybox.sharedPath` | Path of directory to mount | `sharePath` |
|  `busybox.extraEnv` | Additional environment variables | `{}` |
|  `busybox.extraEnvFrom` | Additional envFrom | `[]` |
|  `busybox.extraVolumes` | Additional volumes | `[]` |
|  `busybox.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `busybox.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `busybox.templates` | Additional ConfigMap as a string to be passed to the tpl function. | `{}` |
|  `busybox.annotations` | Grant annotations to ConfigMap of `busybox.templates`, Secrets of `busybox.secrets` | `{}` |

## Nginx Containers

|  Parameter | Description | Default |
| --- | --- | --- |
|  `nginx.image.repository` | The image repository to pull from | `nginx` |
|  `nginx.image.tag` | The image tag to pull | `1.15.1-alpine` |
|  `nginx.image.pullPolicy` | Image pull policy | `IfNotPresent` |
|  `nginx.port` | Default public port of NGINX | `80` |
|  `nginx.lifecycle.postStart` | PostStart of NGINX | `[]` |
|  `nginx.lifecycle.preStop` | PreStop of NGINX | `[]` |
|  `nginx.livenessProbe.httpGet.path` | Overrides the default liveness probe httGet path | `/status` |
|  `nginx.livenessProbe.httpGet.port` | Overrides the default liveness probe httGet port | `7777` |
|  `nginx.livenessProbe.initialDelaySeconds` | Overrides the default liveness probe initialDelaySeconds | `15` |
|  `nginx.livenessProbe.periodSeconds` | Overrides the default liveness probe periodSeconds | `5` |
|  `nginx.livenessProbe.timeoutSeconds` | Overrides the default liveness probe timeoutSeconds | `1` |
|  `nginx.livenessProbe.successThreshold` | Overrides the default liveness probe successThreshold | `1` |
|  `nginx.livenessProbe.failureThreshold` | Overrides the default liveness probe failureThreshold | `3` |
|  `nginx.readinessProbe.httpGet.path` | Overrides the default readiness probe httGet path | `/ping` |
|  `nginx.readinessProbe.httpGet.port` | Overrides the default readiness probe httGet port | `7777` |
|  `nginx.readinessProbe.initialDelaySeconds` | Overrides the default readiness probe initialDelaySeconds | `15` |
|  `nginx.readinessProbe.periodSeconds` | Overrides the default readiness probe periodSeconds | `5` |
|  `nginx.readinessProbe.timeoutSeconds` | Overrides the default readiness probe timeoutSeconds | `1` |
|  `nginx.readinessProbe.successThreshold` | Overrides the default readiness probe successThreshold | `1` |
|  `nginx.readinessProbe.failureThreshold` | Overrides the default readiness probe failureThreshold | `3` |
|  `nginx.resources` | Overrides the default resource | `{}` |
|  `nginx.extraEnv` | Additional environment variables | `{}` |
|  `nginx.extraEnvFrom` | Additional envFrom | `[]` |
|  `nginx.extraPorts` | Additional ports | `[]` |
|  `nginx.extraVolumes` | Additional volumes | `[]` |
|  `nginx.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `nginx.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `nginx.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `nginx.conf`, `conf.d/default.conf`, `conf.d/status.conf` |
|  `nginx.annotations` | Grant annotations to ConfigMap of `nginx.templates`, Secrets of `nginx.secrets` | `{}` |

## PHP Containers

|  Parameter | Description | Default |
| --- | --- | --- |
|  `fpm.image.repository` | The image repository to pull from | `php` |
|  `fpm.image.tag` | The image tag to pull | `7.1-fpm-alpine` |
|  `fpm.image.pullPolicy` | Image pull policy | `IfNotPresent` |
|  `fpm.command` | Overrides the default command | `[]` |
|  `fpm.lifecycle.postStart` | PostStart of FPM | `[]` |
|  `fpm.lifecycle.preStop` | PreStop of FPM | `[]` |
|  `fpm.livenessProbe` | Overrides the default liveness probe | `{}` |
|  `fpm.readinessProbe` | Overrides the default readness probe | `{}` |
|  `fpm.resources` | Overrides the default resource | `{}` |
|  `fpm.extraEnv` | Additional env | `[]` |
|  `fpm.extraEnvFrom` | Additional envFrom | `[]` |
|  `fpm.extraPorts` | Additional ports | `[]` |
|  `fpm.extraVolumes` | Additional volumes | `[]` |
|  `fpm.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `fpm.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `fpm.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `php.ini`,`php-fpm.conf`,`php-fpm.d/www.conf` |
|  `fpm.annotations` | Grant annotations to ConfigMap of `fpm.templates`, Secrets of `fpm.secrets` | `{}` |

### Manage nginx host and port

When changing `host` and `port` of `nginx.conf`,
Change `host` and `port` of `templates.conf.d.default.conf`.

```
  templates:
    conf.d:
      default.conf: |
        server {
            listen      80;
            server_name localhost;
```

### Manage request timeout and graceful shutdown

If you need graceful shutdown according to the request timeout, set as follows.

```
terminationGracePeriodSeconds: {{ your_fpm_process_control_timeout }}

nginx:
  templates:
    conf.d:
      ...
      default.conf: |
        server {
          ...
          location ~ \.php$ {
              include fastcgi_params;
              fastcgi_pass  unix:/var/run/php-fpm/php-fpm.sock;
              fastcgi_index index.php;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
              fastcgi_read_timeout {{ your_fpm_process_control_timeout }}s;
          }
        }

  lifecycle:
    preStop: ["/bin/sh", "-c", "sleep 5; nginx -s quit; sleep {{ your_fpm_process_control_timeout }};"]

fpm:
  templates:
    php-fpm.conf: |
      ...
      process_control_timeout = {{ your_fpm_process_control_timeout }}

  lifecycle:
    preStop: ["/bin/sh", "-c", "sleep 5; kill -QUIT 1; sleep {{ $fpm_request_timeout }} "]
```
