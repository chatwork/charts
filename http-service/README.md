# http-service

An opinionated Helm chart for language-agnostic HTTP services with sensible defaults.

## Install

```sh
helm repo add chatwork https://chatwork.github.io/charts
helm install my-service chatwork/http-service -f values.yaml
```

## Opinionated defaults

| Concern | Default | Rationale |
|---------|---------|-----------|
| Strategy | `RollingUpdate` (maxSurge 25%, maxUnavailable 1) | Zero-downtime deploys |
| PDB | `pod.disruptionBudget.enabled: true`, `maxUnavailable: 1` | Protect availability during node drain |
| Reloader | `enabled: true` | Auto-restart on ConfigMap/Secret changes |
| Datadog tags | `enabled: true` | Unified service tags (`env`, `service`, `version`) on Deployment and Pod |
| Graceful shutdown | Required (`trafficDrainSeconds` + `appShutdownTimeoutSeconds`) | Prevent traffic loss during termination |
| Probes | `startupProbe` and `livenessProbe` required, `readinessProbe` optional | Enforce health check discipline |

## Required values

The following values must be provided — the template will fail with an explicit error if they are missing:

- `image.repository` / `image.tag`
- `gracefulShutdown.trafficDrainSeconds` — seconds to sleep in preStop, waiting for LB deregistration
- `gracefulShutdown.appShutdownTimeoutSeconds` — seconds the app gets after SIGTERM
- `startupProbe`
- `livenessProbe`
- `datadog.env` / `datadog.service` / `datadog.version` (when `datadog.enabled: true`)

## Autoscaling

Controlled by `autoscaling.type`:

| Type | Description |
|------|-------------|
| `none` | Fixed replicas (set `replicas` value) |
| `hpa` | Kubernetes-native HorizontalPodAutoscaler |
| `keda` | KEDA ScaledObject (manages HPA internally) |

When `autoscaling.type` is `hpa` or `keda`, setting `replicas` will cause a template error to prevent conflicts.

## Argo Rollouts

Set `rollout.enabled: true` to create a Rollout resource instead of a Deployment. No Deployment is rendered; the Rollout owns the `selector` and the Pod `template` directly, so every Pod goes through the Rollout strategy. The HPA/KEDA `scaleTargetRef` automatically switches to target the Rollout.

- `rollout.strategy` is required when enabled.
- `replicas` (when `autoscaling.type` is `none`), `revisionHistoryLimit`, `deployment.annotations` and `deployment.labels` are applied to the Rollout. The Deployment `strategy` value is not used.
- With `reloader.enabled`, the Reloader annotation is set on the Rollout. Reloader must have Argo Rollouts support enabled to restart it.

### Upgrading from 0.2.0

In 0.2.0, the Rollout referenced the Deployment via `workloadRef`. Upgrading to 0.3.0 with `rollout.enabled: true` deletes the Deployment and the Rollout takes over the Pod template.

With `autoscaling.type: none`, 0.2.0 applied `replicas` to the Deployment and the Rollout ran 1 Pod. On upgrade, the Deployment's Pods terminate while the Rollout scales up from 1 to `replicas`, so the number of available Pods drops until it catches up.

### Toggling `rollout.enabled` on a running release

Switching `rollout.enabled` on an existing release replaces the Deployment with a Rollout (or vice versa). The old workload's Pods are removed while the new one's Pods are starting, so the number of available Pods drops temporarily.

## Graceful shutdown

The chart auto-generates `terminationGracePeriodSeconds` and a preStop hook:

```
|-- terminationGracePeriodSeconds (drain + app) --|
|-- preStop sleep (drain) --|-- app shutdown ------|
                             ^
                          SIGTERM
```

The preStop sleep holds the container alive while the load balancer finishes deregistering the Pod.

## Examples

See [`examples/`](examples/) for values files covering common patterns:

| File | Pattern |
|------|---------|
| `deployment.yaml` | Basic deployment with fixed replicas |
| `deployment-hpa.yaml` | HPA autoscaling |
| `deployment-ingress.yaml` | Ingress with ALB |
| `deployment-keda.yaml` | KEDA autoscaling |
| `deployment-rollout.yaml` | Argo Rollouts canary with HPA |
| `deployment-rollout-fixed-replicas.yaml` | Argo Rollouts canary with fixed replicas |

## Lint & test

```sh
make lint           # lint all examples
make test           # deploy + helm test (requires cluster)
```
