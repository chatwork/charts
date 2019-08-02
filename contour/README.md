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
|  `contour.imagePullSecrets` | contour imagePullSecrets | `"[]"` |
|  `contour.image.repository` | contour image repository | `"gcr.io/heptio-Image/contour"` |
|  `contour.image.tag` | contour Image tag | `"v0.14.0"` |
|  `contour.image.imagePullPolicy` | contour Image pullpolicy  | `"IfNotPresent"` |
|  `contour.extraArgs` | contour command extra arguments | `"[]"` |
|  `contour.resources` | contour pod resources| `"{}"` |
|  `contour.port.healthz` | contour health check port | `"8000"` |
|  `contour.port.xds` | contour xds port | `"8001"` |
|  `contour.initialDelaySeconds.livenessProbe` | contour initial delay seconds for livenessProbe | `"5"` |
|  `contour.initialDelaySeconds.readinessProbe` | contour initial delay seconds for readinessProbe| `"5"` |
|  `contour.podAnnotations` | contour pod annotations| `"{}"` |
|  `contour.tolerations` | contour tolerations | `"{}"` |
|  `contour.affinity` | contour affinity| `"{}"` |
|  `contour.deployment.autoscaling.enabled` | Use hpa for contour deployment | `"false"` |
|  `contour.deployment.autoscaling.minReplicas` | HPA minReplicas for contour deployment | `"2"` |
|  `contour.deployment.autoscaling.maxReplicas` | HPA maxReplicas for contour deployment | `"5"` |
|  `contour.deployment.autoscaling.metrics` | HPA metrics for contour deployment | `"[]"` |
|  `contour.deployment.strategy` | contour deployment strategy| `"{}"` |
|  `contour.deployment.replicas` | contour deployment replicas | `"1"` |
|  `contour.deployment.pdb` | contour pod disruption budget rule | `"minAvailable: 1"` |
|  `contour.service.annotations` | contour service annotations | `"{}"` |
|  `contour.rbac.create` | contour application service aacount create | `"true"` |
|  `contour.rbac.serviceAccountName` | contour application use serviceAccount which you have created | `"default"` |
|  `envoy.imagePullSecrets` | envoy imagePullSecrets | `"[]"` |
|  `envoy.image.repository` | envoy image repository | `"docker.io/envoyproxy/envoy"` |
|  `envoy.image.tag` | envoy Image tag | `"v1.11.0"` |
|  `envoy.image.imagePullPolicy` | envoy Image pullpolicy  | `"IfNotPresent"` |
|  `envoy.logLevel` | envoy log level | `"info"` |
|  `envoy.extraArgs` | envoy command extra arguments | `"[]"` |
|  `envoy.resources` | envoy pod resources| `"{}"` |
|  `envoy.port.healthz` | envoy health check port | `"8002"` |
|  `envoy.port.http` | envoy http port | `"8080"` |
|  `envoy.port.https` | envoy https port | `"8443"` |
|  `envoy.initialDelaySeconds.livenessProbe` | envoy initial delay seconds for livenessProbe | `"3"` |
|  `envoy.initialDelaySeconds.readinessProbe` | envoy initial delay seconds for readinessProbe| `"3"` |
|  `envoy.podAnnotations` | envoy pod annotations| `"{}"` |
|  `envoy.tolerations` | envoy tolerations | `"{}"` |
|  `envoy.affinity` | envoy affinity| `"{}"` |
|  `envoy.deployment.autoscaling.enabled` | Use hpa for envoy deployment | `"false"` |
|  `envoy.deployment.autoscaling.minReplicas` | HPA minReplicas for envoy deployment | `"2"` |
|  `envoy.deployment.autoscaling.maxReplicas` | HPA maxReplicas for envoy deployment | `"5"` |
|  `envoy.deployment.autoscaling.metrics` | HPA metrics for envoy deployment | `"[]"` |
|  `envoy.deployment.strategy` | envoy deployment strategy| `"{}"` |
|  `envoy.deployment.replicas` | envoy deployment replicas | `"1"` |
|  `envoy.deployment.pdb` | envoy pod disruption budget rule | `"minAvailable: 1"` |
|  `envoy.daemonset.enabled` | envoy pod deploy with daemonset | `"false"` |
|  `envoy.daemonset.hostNetwork` | envoy daemonset use hostNetwork| `"false"` |
|  `envoy.daemonset.updateStrategy` | envoy daemonset updateStrategy | `"{}"` |
|  `envoy.service.annotations` | envoy service annotations | `"service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp"` |
|  `envoy.service.type` | envoy service type | `"LoadBalancer"` |
|  `envoy.service.externalTrafficPolicy` | envoy service externalTrafficPolicy | `"Cluster"` |
|  `envoy.service.port.http` | envoy service http port | `"8080"` |
|  `envoy.service.port.https` | envoy service https port | `"8443"` |
|  `envoy.service.nodePort.http` | if you use specific nodeport for http | `"30000"` |
|  `envoy.service.nodePort.https` | if you use specific nodeport for https | `"30001"` |
