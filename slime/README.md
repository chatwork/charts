# slime

₍Ꙭ̂₎ < Not my bad slime

₍Ꙭ̂₎ < I will transform into anything

## TL;DR;

```
$ helm install chatwork/slime
```

## Prerequisites

* Kubernetes 1.11+

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

## Configuration

The following table lists the configurable parameters of the slime chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `configmaps` | Transform ConfigMap's YAML. You can set `binaryData`, `data` and `metadata` | `[]` |
|  `secret` | Transform Secret's YAML. You can set `data`, `metadata`, `stringData` and `type` | `[]` |