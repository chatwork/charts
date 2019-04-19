## gaurd

https://appscode.com/products/guard/

Guard is a webhook server for Kubernetes authentication.

## TL;DR;

```
$ helm install chatwork/gaurd
```

## Prerequisites

* Kubernetes 1.11+

## Installing the Chart


To install the chart with the release name `my-release`:

```
$ helm install --name my-release chatwork/gaurd
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
|  `replicas` | k8s deployment replicas | `1` |
|  `image.repository` | The image repository to pull from | `"appscode/guard"` |
|  `image.tag` | 	The image tag to pull | `"0.2.1"` |
|  `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
|  `image.pullSecrets` | Image pull secrets | `[]` |
|  `nameOverride` | Override name of app | `""` |
|  `fullnameOverride` | Override full name of app | `""` |
|  `args.verbose` | log level for V logs | `3` |
|  `args.authProvider` | name of providers for which guard will provide authentication service | `"github"` |
|  `runOnMaster` | If true, runs Guard server on master instances | `true` |
|  `ntpServer` | Address of NTP serer used to check clock skew | `s2csntp.miz.nao.ac.jp` |
|  `pki.caCrt` | CA certificate | Default is a certificate for `10.96.10.96` |
|  `pki.tlsCrt` | Server TLS certificate | Default is a certificate for `10.96.10.96` |
|  `pki.tlsKey` | Server TLS private key | Default is a key for `10.96.10.96` |
|  `tlsFilesBase` | TLS file location | `"/etc/guard/pki"` |
|  `containerPort` | Port of guard container | `8443` |
|  `podAnnotation` | Annotations to add to the deployment pods | `{}` |
|  `tolerations` | Allow the deployment to schedule on tainted nodes | `{}` |
|  `affinity` | Allow the deployment to schedule ussing affinity rules | `{}` |
|  `livenessProbe.initialDelaySeconds` |  | `25` |
|  `readinessProbe.initialDelaySeconds` |  | `25` |
|  `resources` | Deployment pod resources | `{}` |
|  `service.clusterIP` | Cluster IP matching server TLS | `10.96.10.96` |
|  `service.port` | Service port | `443` |
|  `rbac.create` | If true, create & use RBAC resources | `true` |
|  `rbac.serviceAccountName` | Name of already existing service account associated with deployment | `default` |

## Create credentials for values.yaml

create server certification

```
# set guard data dir
$ export GUARD_DATA_DIR=$(pwd)

# create ca
$ guard init ca

# create server key
$ openssl genrsa 2048 > pki/server.key

# create server csr
$ openssl req -new -key pki/server.key -out pki/server.csr -subj '/C=JP/ST=Tokyo/L=Minato-ku/O=test/CN=server'

# create server crt
$ openssl x509 -req -in pki/server.csr -CA pki/ca.crt -CAkey pki/ca.key -CAcreateserial -out pki/server.crt -days 3560 -sha256 -extensions SAN -extfile server-v3.txt
```
