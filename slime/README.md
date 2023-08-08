# slime

₍Ꙭ̂₎ < Not my bad slime

₍Ꙭ̂₎ < I will transform into anything

## TL;DR;

```
$ helm install chatwork/slime
```

## Prerequisites

* Kubernetes 1.18+

## Installing the Chart


To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/slime
```

The command deploys the slime chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/slime#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Difference from raw chart

[raw chart](https://github.com/chatwork/charts/tree/master/raw) is is very useful, but it is too flexible and can be difficult to write if you are not used to helm.
Therefore, this chart has some format for writing. If it is a simple `deployment` + `service` + `ingress`, this chart is surely easier to write than `raw chart`,
but it does not allow you to define any resources(CRDS, cert-manager,...) freely.

Use each charts as needed or use them together.

## Configuration

The following table lists the configurable parameters of the slime chart and their default values.

| Parameter                            | Description                                                                                                                  | Default       |
|--------------------------------------|------------------------------------------------------------------------------------------------------------------------------|---------------|
| `nameOverride`                       | Override name of app                                                                                                         | `null`        |
| `fullnameOverride`                   | Override the full qualified app name                                                                                         | `null`        |
| `deployment.enabled`                 | Enable deployment                                                                                                            | `false`       |
| `strategy`                           | rolling update strategy for deployment                                                                                       | `{}`          |
| `annotations`                        | annotations for  deployment                                                                                                  | `{}`          |
| `labels`                             | labels for  deployment                                                                                                       | `{}`          |
| `replicas`                           | replicas for deployment                                                                                                      | `1`           |
| `revisionHistoryLimit`               | revisionHistoryLimit                                                                                                         | `""`          |
| `podAnnotations`                     | pod annotations                                                                                                              | `{}`          |
| `podLabels`                          | pod labels                                                                                                                   | `{}`          |
| `podSecurityContext`                 | pod securityContext                                                                                                          | `{}`          |
| `affinity`                           | affinity                                                                                                                     | `{}`          |
| `nodeSelector`                       | nodeSelector                                                                                                                 | `{}`          |
| `imagePullSecrets`                   | imagePullSecrets                                                                                                             | `[]`          |
| `readinessGates`                     | readinessGates                                                                                                               | `[]`          |
| `priorityClassName`                  | priorityClassName                                                                                                            | `""`          |
| `progressDeadlineSeconds`            | progressDeadlineSeconds                                                                                                      | `""`          |
| `volumes`                            | pod volumes(initContainers, containers)                                                                                      | `[]`          |
| `containers`                         | application containers                                                                                                       | `[]`          |
| `initContainers.enabled`             | if true, you can use initContainers                                                                                          | `false`       |
| `initContainers.containers`          | initContainers config                                                                                                        | `[]`          |
| `configmaps`                         | transform ConfigMap manifest. You can set `binaryData`, `data`                                                               | `{}`          |
| `secrets`                            | transform Secret's manifest. You can set `data`, `stringData` and `type`                                                     | `{}`          |
| `autoscaling.enabled`                | if true, you can use hpa                                                                                                     | `false`       |
| `autoscaling.behavior`               | autscaling behavior https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#configurable-scaling-behavior | `{}`          |
| `autoscaling.metrics`                | autoscaling metrics                                                                                                          | `[]`          |
| `autoscaling.maxReplicas`            | autoscaling maxReplicas                                                                                                      | `2`           |
| `autoscaling.minReplicas`            | autoscaling minReplicas                                                                                                      | `1`           |
| `service.enabled`                    | if true, you can use service                                                                                                 | `false`       |
| `service.type`                       | service type(ClusterIP, NodePort, LoadBalancer)                                                                              | `"ClusterIP"` |
| `service.ports`                      | service ports                                                                                                                | `{}`          |
| `clusterRole.enabled`                | if true, you can use clusterRole                                                                                             | `false`       |
| `clusterRole.rules`                  | clusterRole rules                                                                                                            | `[]`          |
| `role.enabled`                       | if true, you can use role                                                                                                    | `false`       |
| `role.rules`                         | role rules                                                                                                                   | `[]`          |
| `serviceAccount.create`              | if true, you can create serviceAccount                                                                                       | `false`       |
| `serviceAccount.name`                | if you create serviceAccount, you can set name                                                                               | `null`        |
| `serviceAccount.labels`              | service account labels                                                                                                       | `{}`          |
| `serviceAccount.annotations`         | serviceAccount annotations                                                                                                   | `{}`          |
| `podDisruptionBudget.enabled`        | if ture, you can use podDisruptionBudget                                                                                     | `false`       |
| `podDisruptionBudget.annotations`    | podDisruptionBudget annotations                                                                                              | `{}`          |
| `podDisruptionBudget.labels`         | podDisruptionBudget labels                                                                                                   | `{}`          |
| `podDisruptionBudget.maxUnavailable` | podDisruptionBudget maxUnavailable                                                                                           | `null`        |
| `podDisruptionBudget.minAvailable`   | podDisruptionBudget minAvailable                                                                                             | `null`        |
| `ingress.enabled`                    | if true, you can use ingress                                                                                                 | `false`       |
| `ingress.ingresses`                  | ingresses config                                                                                                             | `{}`          |
| `cronJob.enabled`                    | if true, you can use CronJob                                                                                                 | `false`       |
| `cronJob.schedule`                   | CronJob's schedule                                                                                                           | `""`          |
| `cronJob.restartPolicy`              | CronJob restartPolicy                                                                                                        | `null` |
| `cronJob.concurrencyPolicy`          | CronJob concurrencyPolicy                                                                                                    | `null`     |
| `cronJob.failedJobsHistoryLimit`     | CronJob failedJobsHistoryLimit                                                                                               | `null`     |
| `cronJob.startingDeadlineSeconds`    | CronJob startingDeadlineSeconds                                                                                              | `null`     |
| `cronJob.successfulJobsHistoryLimit` | CronJob successfulJobsHistoryLimit                                                                                           | `null`     |
| `cronJob.suspend`                    | CronJob suspend                                                                                                              | `null`     |
| `cronJob.timeZone`                   | CronJob timeZone https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#cronjob-v1-batch                       | `null`     |
| `cronJob.successfulJobsHistoryLimit` | CronJob successfulJobsHistoryLimit                                                                                           | `null`     |
| `cronJob.jobTemplate`                | CronJob jobTemplate https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#jobtemplatespec-v1-batch            | `{}`       |
| `test.enabled`                       | if true, you can use helm test                                                                                               | `false`       |
| `test.containers`                    | helm test container config                                                                                                    | `[]`          |


# generate README

This README is generated with https://github.com/rapidsai/frigate
