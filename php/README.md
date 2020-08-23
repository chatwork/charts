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
|  `labels` | Label specified for deployment | `{}` |
|  `podLabels` | Label specified for pod in deployment | `{}` |
|  `podAnnotations` | Annotation specified for pod in deployment | `{}` |
|  `imagePullSecrets` | Name of Secret resource containing private registry credentials | `[]` |
|  `readinessGates` | Pod readiness extensions | `{}` |
|  `restartPolicy` | Container restart policy | `""` |
|  `terminationGracePeriodSeconds` | Termination grace period (in seconds) | `nil` |
|  `securityContext` | Enable security context | `{}` |
|  `serviceAccountName` | Existing ServiceAccount to use | `""` |
|  `extraVolumes` | Additional volumes to all container | `[]` |
|  `extraVolumeMounts` | Additional volumeMounts to all container | `[]` |
|  `tolerations` | Pod taint tolerations for deployment | `[]` |
|  `affinity` | Node / Pod affinities | `{}` |
|  `service.type` | Changes to ClusterIP automatically if ingress enabled | `LoadBalancer` |
|  `service.port` | Port to advertise the main web service in LoadBalancer mode | `nil` |
|  `service.extraPorts` | Additional ports | `[]` |
|  `service.labels` | Label specified for service | `{}` |
|  `service.annotations` | Annotation specified for service | `{}` |
|  `ingress.enabled` | Enables Ingress | `false` |
|  `ingress.labels` | Label specified for ingress | `{}` |
|  `ingress.annotations` | Annotation specified for ingress | `{}` |
|  `ingress.hosts` | Ingress accepted hostname | `[]` |
|  `ingress.preferPaths` | Paths that takes precedence over the ingress.path | `nil` |
|  `ingress.tls` | TLS Secret (certificates)  | `false` |
|  `podDisruptionBudget.enabled` | If true, create a pod disruption budget for keeper pods | `false` |
|  `podDisruptionBudget.minAvailabled` | Minimum number / percentage of pods that should remain scheduled | `nil` |
|  `podDisruptionBudget.maxAvailabled` | Minimum number / percentage of pods that should remain scheduled | `nil` |
|  `autoscaling.enabled` | If true, create a pod disruption budget for keeper pods | `false` |
|  `autoscaling.minReplicas` | Min pods for HorizontalPodAutoscaler | `nil` |
|  `autoscaling.maxReplicas` | Max pods for HorizontalPodAutoscaler | `nil` |
|  `autoscaling.metrics` | Metrics used for autoscaling | `nil` |
|  `rbac.create` | If true, create & use RBAC resources | `true` |
|  `serviceAccount.create` | If true, create a service account for the pod | `true` |
|  `serviceAccount.annotations` | Annotations for the created service account | `{}` |
|  `serviceAccount.labels` | Labels for the created service account | `{}` |
|  `serviceAccount.name` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `` |
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
|  `nginx.image.tag` | The image tag to pull | `1.17-alpine` |
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
|  `nginx.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `nginx.conf`, `conf.d/default.conf` |
|  `nginx.annotations` | Grant annotations to ConfigMap of `nginx.templates`, Secrets of `nginx.secrets` | `{}` |

## PHP-FPM containers

|  Parameter | Description | Default |
| --- | --- | --- |
|  `fpm.image.repository` | The image repository to pull from | `php` |
|  `fpm.image.tag` | The image tag to pull | `7.4-fpm-alpine` |
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
|  `fpm.templates` | Additional ConfigMap as a string to be passed to the tpl function. | setting `php-fpm.conf`,`www.conf` |
|  `fpm.annotations` | Grant annotations to ConfigMap of `fpm.templates`, Secrets of `fpm.secrets` | `{}` |

### Manage request timeout and graceful shutdown

If you need graceful shutdown according to the request timeout, set as follows.

```
terminationGracePeriodSeconds: {{ your_fpm_process_control_timeout }}

nginx:
  templates:
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

### Manage PHP-FPM logging

To output PHP errors as container logs, configure as follows.

**php.ini**

```
; Besides displaying errors, PHP can also log errors to locations such as a
; server-specific log, STDERR, or a location specified by the error_log
; directive found below. While errors should not be displayed on productions
; servers they should still be monitored and logging is a great way to do that.
; Default Value: Off
; Development Value: On
; Production Value: On
; http://php.net/log-errors
log_errors = On

; Set maximum length of log_errors. In error_log information about the source is
; added. The default is 1024 and 0 allows to not apply any maximum length at all.
; http://php.net/log-errors-max-len
log_errors_max_len = 8192
```

**php-fpm.conf**

```
[global]
; Error log file
; If it's set to "syslog", log is sent to syslogd instead of being written
; into a local file.
; Note: the default prefix is /usr/local/var
; Default Value: log/php-fpm.log
error_log = /proc/self/fd/2

; Log limit on number of characters in the single line (log entry). If the
; line is over the limit, it is wrapped on multiple lines. The limit is for
; all logged characters including message prefix and suffix if present. However
; the new line character does not count into it as it is present only when
; logging to a file descriptor. It means the new line character is not present
; when logging to syslog.
; Default Value: 1024
log_limit = 8192
```

**php-fpm.d/www.conf**

```
[www]
; Redirect worker stdout and stderr into main error log. If not set, stdout and
; stderr will be redirected to /dev/null according to FastCGI specs.
; Note: on highloaded environement, this can cause some delay in the page
; process time (several ms).
; Default Value: no
catch_workers_output = yes

; Decorate worker output with prefix and suffix containing information about
; the child that writes to the log and if stdout or stderr is used as well as
; log level and time. This options is used only if catch_workers_output is yes.
; Settings to "no" will output data as written to the stdout or stderr.
; Default value: yes
decorate_workers_output = no
```

Set `log_errors_max_len` and `log_limit` according to the log length.
By setting `decorate_workers_output`, you can remove PHP-FPM specific output prefix.

```
$ kc logs -c php-fpm php-669bc99b68-t958q --timestamps -f 
2020-02-12T06:26:27.057182729Z [12-Feb-2020 06:26:27] NOTICE: fpm is running, pid 1
2020-02-12T06:26:27.058596594Z [12-Feb-2020 06:26:27] NOTICE: ready to handle connections
2020-02-12T06:29:41.989949895Z NOTICE: PHP message: PHP Fatal error:  Uncaught Error: Call to undefined function hoge() in /var/www/html/index.php:1
2020-02-12T06:29:41.989996608Z Stack trace:
2020-02-12T06:29:41.990004596Z #0 {main}
2020-02-12T06:29:41.990008076Z   thrown in /var/www/html/index.php on line 1
```

Since the log cannot be combined into one line in the PHP setting, use [set_error_handler](https://www.php.net/manual/ja/function.set-error-handler.php) or [set_execption_handler](https://www.php.net/manual/ja/function.set-exception-handler.php) to solve the problem with the application.