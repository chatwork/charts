# tiller

Tiller is a Helm Chart for managing tiller.

## TL;DR;

```
$ helm install chatwork/tiller
```

## Prerequisites

* Kubernetes 1.11+

## Installing the Chart


To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/tiller
```

The command deploys the tiller chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/tiller#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the slime chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `image.repository` | The image repository to pull from | `gcr.io/kubernetes-helm/tiller` |
|  `image.tag` | 	The image tag to pull | `v2.14.3` |
|  `image.pullPolicy` | Image pull policy | `IfNotPresent` |
|  `test.image.repository` | The test image repository to pull from | `chatwork/helm` |
|  `test.image.tag` | The test image tag to pull | `2.14.3` |
|  `test.image.pullPolicy` | Test image pull policy | `IfNotPresent` |
|  `rbac.tiller.create` |  If `true`, create and use RBAC resources | `true` |
|  `rbac.tiller.serviceAccountName` | Service account to be used | `default` |
|  `rbac.tiller.rules` | [Rule](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#policyrule-v1-rbac-authorization-k8s-io) to allow in rback | `[{apiGroups:["","batch","extensions"      - "apps","autoscaling","rbac.authorization.k8s.io","scheduling.k8s.io","storage.k8s.io","policy"],resources:["*"],verbs:["*"]}]` |
|  `rbac.client.create` | If true, create tiller client which have appropriate privileges and this client is used in test pod | `true` |
|  `rbac.client.serviceAccountName` | Service account for test pod, if you have already created tiller client role and won't create new sa | `default` |
|  `rbac.client.rules` | [Rule](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#policyrule-v1-rbac-authorization-k8s-io) to allow in rback | `[{apiGroups:[""],resources:["pods/portforward"],verbs:["create"],{apiGroups:[""],resources:["pods"],verbs:["list"]}]` |
