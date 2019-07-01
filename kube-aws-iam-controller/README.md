# kube-aws-iam-controller

[kube-aws-iam-controller](https://github.com/mikkeloscar/kube-aws-iam-controller) is controller for AWS credential for pod using secrets.

# Prerequisites

Kubernetes 1.11+

# AWS Role

It is necessary to create an IAM role which can assume other roles and assign it to kubernetes worker which running kube-aws-iam-controller pod.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```

When running on workers, it is difficult to fix which worker it is, we recommend to run on the controller.

Alternatively, you can create secrets for role using kube-aws-iam-controller and set them in environment variable.

The roles that will be assumed with node which running kube-aws-iam-controller(if you use instance profile) must have a Trust Relationship which allows them to be assumed by the node which running kube-aws-iam-controller.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:role/kube-node-role-which-running-kube-aws-iam-controller"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

# Quick start

```
$ kubectl apply -f https://raw.githubusercontent.com/mikkeloscar/kube-aws-iam-controller/v0.1.0/docs/aws_iam_role_crd.yaml
$ helm install --name <RELEASE_NAME> \ chatwork/kube-aws-iam-controller
```

# Configuration options

If `useHostNetwork` is true, pod use the host's network, that's because of    running pod with hostNetwork to bypass metadata service block from pod network.

|  Parameter | Description | Default |
| --- | --- | --- |
| `image.repository` | The image repository to pull from | `mikkeloscar/kube-aws-iam-controller`|
| `image.tag` | The image tag to pull | `v0.0.5`|
| `image.imagePullPolicy` | Image pull policy | `IfNotPresent` |
| `deployment.useHostNetwork` | If true, use the host's network | `false` |
| `deployment.onMaster` | If true, pod running on master | `false`|
| `deployment.nodeSelector` | Set nodeSelector | `{}`|
| `deployment.affinity` | Set Affinity | `{}` |
| `deployment.podLabels` | Set Pod labels | `{}` |
| `deployment.podAnnotations` | Set Pod annotations | `{}`|
| `deployment.tolerations` | Set Pod tolerations | `[]`|
| `deployment.priorityClassName` | Set Pod priorityClassName | `""`|
| `deployment.args` | Set command args | `[]` |
| `deployment.env` | Set Environment Variable | `[]` |
| `deployment.volumeMounts` | Set volumeMounts | `[]` |
| `deployment.volumes` | Set volumes | `[]` |
| `deployment.resources.limits.cpu` | Set cpu limit | `100m` |
| `deployment.resources.limit.memory` | Set memory limit | `256Mi` |
| `deployment.resources.requests.cpu` | Set cpu request | `25m` |
| `deployment.resources.request.memory` | Set memory request | `100Mi` |
| `rbac.create` | If true, create rbac resources(sa, clusterole, clusterrolebinding) | `true`
