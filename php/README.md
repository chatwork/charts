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
|  `podAnnotation` | Annotation specified for pod in deployment | {} |
|  `imagePullSecrets` | Name of Secret resource containing private registry credentials | `[]` |
|  `tolerations` | Pod taint tolerations for deployment | `[]` |
|  `affinity` | Node / Pod affinities | `{}` |
|  `service.type` | Changes to ClusterIP automatically if ingress enabled | `LoadBalancer` |
|  `service.port` | Port to advertise the main web service in LoadBalancer mode | `8080` |
|  `service.extraPorts` | Additional ports | `8080` |
|  `ingress.enabled` | Enables Ingress | `FALSE` |
|  `ingress.annotation` | Ingress annotations |  |
|  `ingress.hosts` | Ingress accepted hostname | `[]` |
|  `ingress.port` | Ingress port | service.port or nginx.port |
|  `ingress.preferPaths` | Paths that takes precedence over the ingress.path |  |
|  `ingress.tls` | TLS Secret (certificates)  |  |
|  `podDisruptionBudget.enabled` | If true, create a pod disruption budget for keeper pods | `FALSE` |
|  `podDisruptionBudget.minAvailabled` | Minimum number / percentage of pods that should remain scheduled |  |
|  `podDisruptionBudget.maxAvailabled` | Minimum number / percentage of pods that should remain scheduled |  |
|  `extras.templates` | Additional raw Kubernetes resources | `{}` |
|  `test.enabled` | Enables helm test | `TRUE` |
|  `test.extraContainers` | Additional containers |  |

### Init Containers

Initialize using busybox.
By default, we use [busybox](https://hub.docker.com/_/busybox), but you can use your container.
We recommend that you embed the source code in your container and copy it to the container of PHP and NGINX in the initialization process.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `busybox.enabled` | Enables initial containers and share volume with busybox | `TRUE` |
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
|  `nginx.livenessProbe` | Overrides the default liveness probe | HTTP `/status` port `7777` |
|  `nginx.readinessProbe` | Overrides the default readness probe | HTTP `/ping` port `7777` |
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
|  `fpm.ini` | Override the default php.ini. Please specify the parameter name with Lower Camel Case |  |
|  `fpm.livenessProbe` | Overrides the default liveness probe | `{}` |
|  `fpm.readinessProbe` | Overrides the default readness probe | `{}` |
|  `fpm.resources` | Overrides the default resource | `{}` |
|  `fpm.extraEnv` | Additional env | `[]` |
|  `fpm.extraEnvFrom` | Additional envFrom | `[]` |
|  `fpm.extraPorts` | Additional ports | `[]` |
|  `fpm.extraVolumes` | Additional volumes | `[]` |
|  `fpm.extraVolumeMounts` | Additional volumeMounts | `[]` |
|  `fpm.secrets` | Additional Secret as a string to be passed to the tpl function | `{}` |
|  `fpm.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `php-fpm.conf`、`php-fpm.d/www.conf` |
|  `fpm.annotations` | Grant annotations to ConfigMap of `fpm.templates`, Secrets of `fpm.secrets` | `{}` |

### Default PHP-FPM Configuration


In the PHP container, you can make some settings by default.
If you want to set other values​​, please overwrite `fpm.templates`.

For details of each value, please see [here](http://php.net/manual/en/install.fpm.configuration.php).


#### Global Configuration

|  Parameter | Default |
| --- | --- |
|  `fpm.logLevel` | `notice` |
|  `fpm.emergencyRestartThreshold`  | `0` |
|  `fpm.emergencyRestartInterval` | `0` |
|  `fpm.processControlTimeout` | `0` |

#### Pool Configuration
|  Parameter | Default |
| --- | --- |
|  `fpm.user` | `nobody` |
|  `fpm.group` | `nobody` |
|  `fpm.mode` | `600` |
|  `fpm.pm.maxChildren` | `5` |
|  `fpm.pm.maxRequests` | `500` |
|  `fpm.pm.status` | `/status.php` |
|  `fpm.requestTerminateTimeout` | `0` |


