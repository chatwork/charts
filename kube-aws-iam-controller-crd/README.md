# kube-aws-iam-controller-crd

This chart creates awsiamrole crd.
kube-aws-iam-controller: https://github.com/mikkeloscar/kube-aws-iam-controller

## TL;DR;

```
$ helm install chatwork/kube-aws-iam-controller-crd \
    --set roleReference=arn:aws:iam::<account-id>:role/aws-iam-role-name
```

## Prerequisites

* Kubernetes 1.11+

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/kube-aws-iam-controller-crd \
    --set roleReference=arn:aws:iam::<account-id>:role/aws-iam-role-name
```
```

The command deploys the kube-aws-iam-controller-crd chart on the Kubernetes cluster with `roleReference` value. The [configuration](https://github.com/chatwork/charts/tree/master/kube-aws-iam-controller-crd#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the kube-aws-iam-controller-crd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
| `roleSecretName` | Secret Name for role using application volumemount | `aws-iam-role` |
|  `roleReference` | Role using application(only rolename or role arn) | `arn:aws:iam::<account-id>:role/AWS_ROLE_NAME` |
|  `roleSessionDuration` | Session Duration with iam role(seconds) | `3600` |
