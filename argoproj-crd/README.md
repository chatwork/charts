# argoproj-crd

Manage [AppProject](https://argoproj.github.io/argo-cd/operator-manual/project.yaml) and [Application](https://argoproj.github.io/argo-cd/operator-manual/application.yaml) that you define for [Argo CD](https://argoproj.github.io/argo-cd/).

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release \
    --set name="my-project" \
    --set description="Example Project" \
    chatwork/argoproj-crd
```

## Configuration

The following table lists the configurable parameters of the argoproj-crd chart and their default values.

|  Parameter | Description | Default |
| --- | --- | --- |
| `name` | Unique project name in Argo CD | `nil` |
| `description` | Project description | `nil` |
| `applications[].name` | Application name in Argo CD | `nil` |
| `applications[].repoURL` | Repository URL to be the source of the application | `nil` |
| `applications[].targetRevision` | HEAD/branch/tag/commit hash | `nil` |
| `applications[].path` | Path from the root of the repository that will be the source of the application | `nil` |
| `applications[].helm` | helm specific config | `nil` |
| `applications[].kustomize` | kustomize specific config | `nil` |
| `applications[].directory` | directory | `nil` |
| `applications[].plugin` | plugin specific config | `nil` |
| `applications[].server` | Destination cluster to deploy the application | `nil` |
| `applications[].namespace` | Destination namespace to deploy the application | `nil` |
| `applications[].syncPolicy` | Sync policy | `automated: {}` |
| `applications[].ignoreDifferences` | Ignore differences at the specified json pointers | `[]`  |
| `clusterResourceWhitelist` | Deny all cluster-scoped resources from being created, except for Namespace. | `[]` |
| `namespaceResourceBlacklist` | Allow all namespaced-scoped resources to be created, except for ResourceQuota, LimitRange, NetworkPolicy. | `[]` |
| `roles[]` | Role that operates in the project | `[]` |

## Namespace

argoproj-crd creates a namespace specified for the application.

```yaml
applications: []
- name: guestbook
  repoURL: https://github.com/argoproj/argocd-example-apps.git
  targetRevision: HEAD
  path: guestbook

  server: https://kubernetes.default.svc
  namespace: guestbook
```

or

```yaml
applications: []
- name: guestbook
  repoURL: https://github.com/argoproj/argocd-example-apps.git
  targetRevision: HEAD
  path: guestbook

  server: https://kubernetes.default.svc
  namespace:
    metadata:
      name: guestbook
      annotations:
        iam.amazonaws.com/permitted: ".*"
```
