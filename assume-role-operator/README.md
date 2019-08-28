# assume-role-operator

[assume-role-operator](https://github.com/chatwork/assume-role-operator) is operator for management AWS iam assume policy.

# Prerequisites

Kubernetes 1.11+

# AWS Role

It is necessary to create an IAM role and assign it to kubernetes worker which running assume-role-operator pod.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:List*",
                "cloudformation:DescribeStackEvents",
                "cloudformation:DescribeStacks"
            ],
            "Resource": [
                "arn:aws:cloudformation:*:*:stack/*/*",
                "arn:aws:iam::*:role/*"
            ]
        }
    ]
}
```

When running on workers, it is difficult to fix which worker it is, we recommend to run on the controller.

Alternatively, you can create secrets for role using assume-role-operator and set them in environment variable.

Or you can use kiam/kube2iam/kube-aws-iam-controller for assign role to assume-role-operator pod.

The roles that will be assumed with node which running assume-role-operator(if you use instance profile) must have a Trust Relationship which allows them to be assumed by the node which running assume-role-operator.

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
        "AWS": "arn:aws:iam::123456789012:role/kube-node-role-which-running-assume-role-operator"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

# Quick start

```
helm install --name <RELEASE_NAME> \ chatwork/assume-role-operator
```

# Configuration options

If `useHostNetwork` is true, pod use the host's network, that's because of    running pod with hostNetwork to bypass metadata service block from pod network.

|  Parameter | Description | Default |
| --- | --- | --- |
| `image.repository` | The image repository to pull from | `chatwork/assume-role-operator`|
| `image.tag` | The image tag to pull | `latest`|
| `image.imagePullPolicy` | Image pull policy | `IfNotPresent` |
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
