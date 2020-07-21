# aws-alb-ingress-controller

[aws-alb-ingress-controller](https://github.com/kubernetes-sigs/aws-alb-ingress-controller) satisfies Kubernetes ingress resources by provisioning Application Load Balancers.

## TL;DR:

```bash
helm repo add chatwork https://chatwork.github.io/charts
helm install chatwork/aws-alb-ingress-controller --set clusterName=MyClusterName --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true
```

## Introduction

This chart bootstraps an alb-ingress-controller deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.9+ with Beta APIs enabled

## Enable helm repository

```bash
helm repo add chatwork https://chatwork.github.io/charts
```

## Installing the Chart
To install the chart with the release name `my-release` into `kube-system`:

```bash
helm install chatwork/aws-alb-ingress-controller --set clusterName=MyClusterName --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true --name my-release --namespace kube-system
```

The command deploys alb-ingress-controller on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the alb-ingress-controller chart and their default values.

| Parameter                 | Description                                                                                                    | Default                                                                   |
| ------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `clusterName`             | (REQUIRED) Resources created by the ALB Ingress controller will be prefixed with this string                   | N/A                                                                       |
| `awsRegion`               | AWS region of k8s cluster, required if ec2metadata is unavailable from controller pod                          | `ap-northeast-1`                                                              |
| `autoDiscoverAwsRegion`   | auto discover awsRegion from ec2metadata, omit awsRegion when this set to true                                 | false                                                                     |
| `awsVpcID`                | AWS VPC ID of k8s cluster, required if ec2metadata is unavailable from controller pod                          | `vpc-xxx`                                                                 |
| `autoDiscoverAwsVpcID`    | auto discover awsVpcID from ec2metadata, omit awsRegion when this set to true                                  | false                                                                     |
| `image.repository`        | controller container image repository                                                                          | `docker.io/amazon/aws-alb-ingress-controller`                             |
| `image.tag`               | controller container image tag                                                                                 | `v1.1.5`                                                                  |
| `image.pullPolicy`        | controller container image pull policy                                                                         | `IfNotPresent`                                                            |
| `extraArgs`               | map of extra arguments to be setting for controller pod                                                        | `{}`                                                                      |
| `livenessProbe.enable`               | enable livenessProbe on controller pod                                                              | `true`                                                                   |
| `livenessProbe.periodSeconds`        |  How often (in seconds) to check controller liveness                                                |    60                                                                    |
| `livenessProbe.timeoutSeconds`       | How long to wait before timeout (in seconds) when checking controller liveness                      |    3                                                                     |
| `livenessProbe.initialDelaySeconds`  | How long to wait (in seconds) before checking the readiness                                         |   30                                                                    |
| `readinessProbe.enable`              | enable readinessProbe on controller pod                                                             | `true`                                                                   |
| `readinessProbe.periodSeconds`       |  How often (in seconds) to check controller readiness                                               |    60                                                                    |
| `readinessProbe.timeoutSeconds`      | How long to wait before timeout (in seconds) when checking controller readiness                     |    1                                                                     |
| `readinessProbe.initialDelaySeconds` | How long to wait (in seconds) before checking the readiness                                         |    30                                                                     |
| `extraEnv`                           | list of environment variables to be injected into the controller pod                                | `[]`                                                                     |
| `envValueFromConfigMap`              | map of environment variables from configmap with `valueFrom` to be injected into the controller pod | `{}`                                                                     |
| `envValueFromSecret`                 | map of environment variables from secret with `valueFrom` to be injected into the controller pod    | `{}`                                                                     |
| `extraEnvFrom`                      | map of environment variables from configmap/secret with `envFrom` to be injected into the controller pod   | `{}`                                                                     |
| `volumesMounts`           | volumeMounts into the controller pod                                                                           | `[]`                                                                      |
| `volumes`                 | volumes the controller pod                                                                                     | `[]`                                                                      |
| `tolerations`             | controller pod toleration for taints                                                                           | `{}`                                                                      |
| `podAnnotations`          | annotations to be added to controller pod                                                                      | `{}`                                                                      |
| `podLabels`               | labels to be added to controller pod                                                                           | `{}`                                                                      |
| `priorityClassName`       | set to ensure your pods survive resource shortages                                                             | `""`                                                                      |
| `deployment.labels`       | labels to be added to deployment                                                                               | `{}`                                                                      |
| `deployment.annotations`  | annotations to be added to deployment                                                                          | `{}`                                                                      |
| `deployment.replicacount` | set to replica count for deployment                                                                            | `1`                                                                      |
| `resources`               | controller pod resource requests & limits                                                                      | `{}`                                                                      |
| `rbac.create`             | If true, create & use RBAC resources                                                                           | `true`                                                                    |
| `rbac.serviceAccount.create` | If true and rbac.create is also true, a service account will be created                                      | `true`
| `rbac.serviceAccount.name`   | existing ServiceAccount to use (ignored if rbac.create=true and rbac.serviceAccount.create=true)             | `default`
| `rbac.serviceAccountAnnotations` | Service Account annotations                                                                              | `{}`                                                                      |
| `psp.create`              | If true, create resource for pod security policy                                                               | `false`                                                                   |
| `containerSecurityContext`| set to security context for container                                                                          | `{}`                                                                      |
| `securityContext`         | set to security context for pod                                                                                | `{}`                                                                      |
| `scope.ingressClass`      | If provided, the ALB ingress controller will only act on Ingress resources annotated with this class           | `alb`                                                                     |
| `scope.watchNamespace`    | the ALB ingress controller will only act on Ingress resources in this namespace | `""` (namespace of the ALB ingress controller)                            |

```bash
helm install chatwork/aws-alb-ingress-controller --set clusterName=MyClusterName --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true --name my-release --namespace kube-system
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install chatwork/aws-alb-ingress-controller --name my-release -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

> **Tip**: If you use `aws-alb-ingress-controller` as releaseName, the generated pod name will be shorter.(e.g. `aws-alb-ingress-controller-66cc9fb67c-7mg4w` instead of `my-release-aws-alb-ingress-controller-66cc9fb67c-7mg4w`)
