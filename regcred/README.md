# Regcred

Regcred creates [Secrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) to pull the image from the Private Registry.

## Installing the Chart

To install the chart with the release name `regcred`:

```
$ helm install --name regcred \
    --set server=https://index.docker.io/v1/ \
    --set username=[your username] \
    --set password=[your password] \
    --set email=[your email] \
    chatwork/regcred
```

Pulling image from Private Registry by specifying `imagePullSecrets[].name` like this:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: <your-private-image>
  imagePullSecrets:
  - name: regcred
```

## Configuration

The following table lists the configurable parameters of the regcred chart and their default values.

|             Parameter       |            Description             |                    Default                |
|-----------------------------|------------------------------------|-------------------------------------------|
| `regcred.server`            | Docker registry URL                | `https://index.docker.io/v1/`             |
| `regcred.username`          | Username to login on Docker registry | `""`                                    |
| `regcred.password`          | Password to login on Docker registry | `""`                                    |
| `regcred.email`             | Email address of Docker registry   | `""`                                      |
| `regcred.dockerconfigjson`  | Encoded authentication information. used when not using user name and password. | `Nil` |

### Secret

You can choose between `username`/`password` and `dockerconfigjson`.
If you use `dockerconfigjson`, please refer to the [link](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#inspecting-the-secret-regcred).