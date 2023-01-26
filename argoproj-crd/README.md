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
| `project.name` | Unique project name in Argo CD | `nil` |
| `project.description` | Project description | `nil` |
| `project.destinations` | Destinations contains list of destination cluster and namespace | `[{"server"=>"https://kubernetes.default.svc", "namespace"=>"default"}]` |
| `project.clusterResourceWhitelist` | ClusterResourceWhitelist contains list of whitelisted cluster level resources | `[]` |
| `project.namespaceResourceBlacklist` | NamespaceResourceBlacklist contains list of blacklisted namespace level resources | `""` |
| `project.namespaceResourceWhitelist` | Allow all namespaced-scoped resources to be created, except for ResourceQuota, LimitRange, NetworkPolicy. | `""` |
| `project.orphanedResources` | OrphanedResources specifies if controller should monitor orphaned resources of apps in this project | `""` |
| `project.roles` | Roles are user defined RBAC roles associated with this project | `""` |
| `project.syncWindows` | SyncWindows controls when syncs can be run for apps in this project | `""` |
| `applications[].name` | Application name in Argo CD | `nil` |
| `applications[].namespace` | Application resource namespace Argo CD must be 2.5 or higher | `nil` |
| `applications[].repoURL` | Repository URL to be the source of the application | `nil` |
| `applications[].targetRevision` | HEAD/branch/tag/commit hash | `nil` |
| `applications[].path` | Path from the root of the repository that will be the source of the application | `nil` |
| `applications[].helm` | helm specific config | `nil` |
| `applications[].kustomize` | kustomize specific config | `nil` |
| `applications[].directory` | directory | `nil` |
| `applications[].plugin` | plugin specific config | `nil` |
| `applications[].destination.server` | Destination cluster to deploy the application | `nil` |
| `applications[].destination.namespace` | Destination namespace to deploy the application | `nil` |
| `applications[].syncPolicy` | Sync policy | `automated: {}` |
| `applications[].ignoreDifferences` | Ignore differences at the specified json pointers | `[]`  |

## ToDo

- separate appproject and application
  - Right now they are configured to be created together, but there could be use cases where you want to create them separately (e.g. different management teams for projects and applications), so we need to be able to create them separately.
