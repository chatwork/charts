# assume-role-crd

This chart creates a assumerole crd.
assume-role-operator: https://github.com/chatwork/assume-role-operator

## TL;DR;

```
$ helm install chatwork/assume-role-crd
```

## Prerequisites

* Kubernetes 1.11+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/assume-role-crd
```

The command deploys the assume-role-crd chart on the Kubernetes cluster in the default configuration. The [configuration](https://github.com/chatwork/charts/tree/master/assume-role-crd#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the assume-role-crd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
|  `clusterName` | Same clusterName in kube-aws cluster.yaml | `nil` |
|  `roleArn` | ARN of IAM Role to assume | `nil` |
