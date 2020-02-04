# PHP

![image](https://user-images.githubusercontent.com/7764002/52184551-166d3680-2858-11e9-8824-5ecd3b11efcc.png)

PHP is a chart for creating PHP web applications.

## TL;DR;

```
$ helm install chatwork/php
```

## Prerequisites

* Kubernetes 1.12+ with Beta APIs enabled
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
|  `terminationGracePeriodSeconds` | Termination grace period (in seconds) | `nil` |
|  `securityContext` | Enable security context | `""` |
|  `serviceAccountName` | Existing ServiceAccount to use | `""` |
|  `extraVolumes` | Additional volumes to all container | `[]` |
|  `extraVolumeMounts` | Additional volumeMounts to all container | `[]` |
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
|  `autoscaling.enabled` | If true, create a pod disruption budget for keeper pods | `false` |
|  `autoscaling.minReplicas` | Min pods for HorizontalPodAutoscaler | `nil` |
|  `autoscaling.maxReplicas` | Max pods for HorizontalPodAutoscaler | `nil` |
|  `autoscaling.targetCPUUtilizationPercentage` | CPU threshold percent for HorizontalPodAutoscaler | `nil` |
|  `autoscaling.targetMemoryUtilizationPercentage` | Memory threshold percent for HorizontalPodAutoscaler | `nil` |
|  `extras.templates` | Additional raw Kubernetes resources | `{}` |
|  `test.enabled` | Enables helm test | `true` |

### Init containers

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
|  `busybox.extraEnv` | Additional environment variables | `[]` |
|  `busybox.extraEnvFrom` | Additional envFrom | `[]` |
|  `busybox.extraVolumes` | Additional volumes | `[]` |
|  `busybox.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `busybox.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `busybox.templates` | Additional ConfigMap as a string to be passed to the tpl function. | `{}` |
|  `busybox.annotations` | Grant annotations to ConfigMap of `busybox.templates`, Secrets of `busybox.secrets` | `{}` |

## Nginx containers

|  Parameter | Description | Default |
| --- | --- | --- |
|  `nginx.image.repository` | The image repository to pull from | `nginx` |
|  `nginx.image.tag` | The image tag to pull | `1.15.1-alpine` |
|  `nginx.image.pullPolicy` | Image pull policy | `IfNotPresent` |
|  `nginx.command` | Command to execute | `[]` |
|  `nginx.containerPort` | Listen port of NGINX container | `80` |
|  `nginx.lifecycle` | NGINX container lifecycle hooks | `{}` |
|  `nginx.livenessProbe` | Liveness probe settings | `{ "httpGet": { "path": "/status", "port": 7777 } "initialDelaySeconds": 15, "periodSeconds": 5, "timeoutSeconds": 1, "successThreshold": 1, "failureThreshold": 3 }` |
|  `nginx.readinessProbe` | Readiness probe settings | `{ "httpGet": { "path": "/ping", "port": 7777 } "initialDelaySeconds": 15, "periodSeconds": 5, "timeoutSeconds": 1, "successThreshold": 1, "failureThreshold": 3 }` |
|  `nginx.resources` | NGINX resources requests & limits | `[]` |
|  `nginx.extraEnv` | Additional environment variables | `{}` |
|  `nginx.extraEnvFrom` | Additional envFrom | `[]` |
|  `nginx.extraPorts` | Additional ports | `[]` |
|  `nginx.extraVolumes` | Additional volumes | `[]` |
|  `nginx.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `nginx.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `nginx.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `nginx.conf`, `conf.d/default.conf`, `conf.d/status.conf` |
|  `nginx.annotations` | Grant annotations to ConfigMap of `nginx.templates`, Secrets of `nginx.secrets` | `{}` |

## PHP-FPM containers

|  Parameter | Description | Default |
| --- | --- | --- |
|  `fpm.image.repository` | The image repository to pull from | `php` |
|  `fpm.image.tag` | The image tag to pull | `7.1-fpm-alpine` |
|  `fpm.image.pullPolicy` | Image pull policy | `IfNotPresent` |
|  `fpm.command` | Command to execute | `[]` |
|  `fpm.lifecycle` | PHP-FPM container lifecycle hooks | `{}` |
|  `fpm.livenessProbe` | Liveness probe settings | `{}` |
|  `fpm.readinessProbe` | Readiness probe settings | `{}` |
|  `fpm.resources` | PHP-FPM resources requests & limits | `{}` |
|  `fpm.extraEnv` | Additional environment variables | `[]` |
|  `fpm.extraEnvFrom` | Additional envFrom | `[]` |
|  `fpm.extraPorts` | Additional ports | `[]` |
|  `fpm.extraVolumes` | Additional volumes | `[]` |
|  `fpm.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `fpm.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `fpm.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `php.ini`,`php-fpm.conf`,`php-fpm.d/www.conf` |
|  `fpm.annotations` | Grant annotations to ConfigMap of `fpm.templates`, Secrets of `fpm.secrets` | `{}` |

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
