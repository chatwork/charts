# newrelic-php-agent

newrelic-php-agent is works the function of Newrelic's PHP agent process

## Prerequisites

* Kubernetes 1.11+

## Quick start
By default, the newrelic-php-agent runs in a DaemonSet.
### Installing the newrelic-php-agent Chart
```
helm install --name <RELEASE_NAME> \ chatwork/newrelic-php-agent
```

## Configuration options

The following table lists the configurable parameters of the newrelic-php-agent chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
| `image.repository` | The image repository to pull from | `chatwork/newrelic-php-agent`|
| `image.tag` | The image tag to pull | `0.0.1`|
| `image.imagePullPolicy` | Image pull policy | `IfNotPresent` |
| `image.command` | Image Entrypoint | `[]` |