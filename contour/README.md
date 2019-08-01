## contour

This chart for contour https://github.com/heptio/contour.

## TL;DR;

```
$ kubectl apply -f crd.yaml
$ helm install chatwork/contour
```

## Prerequisites

* Kubernetes 1.11+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/contour
```

The command deploys the gaurd chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/gaurd#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the gaurd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `deployment.contour.autoscaling.enabled` | Use hpa for contour deployment | `"false"` |
|  `deployment.contour.autoscaling.minReplicas` | HPA minReplicas for contour deployment | `"2"` |
|  `deployment.contour.autoscaling.maxReplicas` | HPA maxReplicas for contour deployment | `"5"` |
|  `deployment.contour.autoscaling.metrics` | HPA metrics for contour deployment | `"[]"` |
|  `deployment.contour.strategy` | Deployment strategy for contour | `"{}"` |
|  `deployment.contour.imagePullSecrets` | imagePullSecrets for contour | `"[]"` |
|  `deployment.contour.replicas` | Deployment replicas for contour | `"2"` |
|  `deployment.contour.image.repository` | Image repository for contour | `"gcr.io/heptio-Image/contour"` |
|  `deployment.contour.image.tag` | Image tag for contour | `"v0.14.0"` |
|  `deployment.contour.image.imagePullPolicy` | Image pullpolicy for contour | `"IfNotPresent"` |
|  `deployment.contour.extraArgs` | Command extra arguments for contour | `"[]"` |
|  `deployment.contour.extraArgs` | Command extra arguments for contour | `"[]"` |

