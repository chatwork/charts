This chart was copied from [helm/charts](https://github.com/helm/charts/tree/master/stable/metrics-server) because it is no longer updated.


This software includes the work that is distributed in the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).	This software includes the work that is distributed in the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).


# metrics-server

[Metrics Server](https://github.com/kubernetes-incubator/metrics-server) is a cluster-wide aggregator of resource usage data. Resource metrics are used by components like `kubectl top` and the [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale) to scale workloads. To autoscale based upon a custom metric, see the [Prometheus Adapter chart](https://github.com/helm/charts/blob/master/stable/prometheus-adapter).

## Configuration

Parameter | Description | Default
--- | --- | ---
`rbac.create` | Enable Role-based authentication | `true`
`serviceAccount.create` | If `true`, create a new service account | `true`
`serviceAccount.name` | Service account to be used. If not set and `serviceAccount.create` is `true`, a name is generated using the fullname template | ``
`apiService.create` | Create the v1beta1.metrics.k8s.io API service | `true`
`apiService.apiVersion` | Kind: APIService's apiVersion | `apiregistration.k8s.io/v1`
`hostNetwork.enabled` | Enable hostNetwork mode | `false`
`image.repository` | Image repository | `k8s.gcr.io/metrics-server/metrics-server`
`image.tag` | Image tag | `v0.5.0`
`image.pullPolicy` | Image pull policy | `IfNotPresent`
`imagePullSecrets` | Image pull secrets | `[]`
`args` | Command line arguments | `[]`
`resources` | CPU/Memory resource requests/limits. | `{}`
`tolerations` | List of node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`nodeSelector` | Node labels for pod assignment | `{}`
`affinity` | Node affinity | `{}`
`replicas` | Number of replicas | `1`
`extraVolumeMounts` | Ability to provide volume mounts to the pod | `[]`
`extraVolumes` | Ability to provide volumes to the pod | `[]`
`livenessProbe` | Container liveness probe | See values.yaml
`podLabels` | Labels to be added to pods | `{}`
`podAnnotations` | Annotations to be added to pods | `{}`
`priorityClassName` | Pod priority class | `""`
`readinessProbe` | Container readiness probe | See values.yaml
`service.annotations` | Annotations to add to the service | `{}`
`service.labels` | Labels to be added to the metrics-server service | `{}`
`service.port` | Service port to expose | `443`
`service.type` | Type of service to create | `ClusterIP`
`podDisruptionBudget.enabled` | Create a PodDisruptionBudget | `false`
`podDisruptionBudget.minAvailable` | Minimum available instances; ignored if there is no PodDisruptionBudget |
`podDisruptionBudget.maxUnavailable` | Maximum unavailable instances; ignored if there is no PodDisruptionBudget |
`extraContainers`   | Add additional containers  | `[]`
`testImage.repository` | Image repository and name for test pod.  See also `imagePullSecrets` | `busybox`
`testImage.tag` | Image tag for test pod | `latest`
`testImage.pullPolicy` | Image pull policy for test pod | `IfNotPresent`
