# http-service

An opinionated Helm chart for language-agnostic HTTP services with sensible defaults.

## Install

\`\`\`sh
helm repo add chatwork https://chatwork.github.io/charts
helm install my-service chatwork/http-service -f values.yaml
\`\`\`

## Opinionated defaults

| Concern | Default | Rationale |
|---------|---------|-----------|
| Strategy | \`RollingUpdate\` (maxSurge 25%, maxUnavailable 1) | Zero-downtime deploys |
| PDB | \`enabled: true\`, \`maxUnavailable: 1\` | Protect availability during node drain |
| Reloader | \`enabled: true\` | Auto-restart on ConfigMap/Secret changes |
| Datadog tags | \`enabled: true\` | Unified service tags (\`env\`, \`service\`, \`version\`) on Deployment and Pod |
| Graceful shutdown | Required (\`trafficDrainSeconds\` + \`appShutdownTimeoutSeconds\`) | Prevent traffic loss during termination |
| Probes | \`startupProbe\` and \`livenessProbe\` required, \`readinessProbe\` optional | Enforce health check discipline |

## Required values

The following values must be provided — the template will fail with an explicit error if they are missing:

- \`image.repository\` / \`image.tag\`
- \`gracefulShutdown.trafficDrainSeconds\` — seconds to sleep in preStop, waiting for LB deregistration
- \`gracefulShutdown.appShutdownTimeoutSeconds\` — seconds the app gets after SIGTERM
- \`startupProbe\`
- \`livenessProbe\`
- \`datadog.env\` / \`datadog.service\` / \`datadog.version\` (when \`datadog.enabled: true\`)

## Autoscaling

Controlled by \`autoscaling.type\`:

| Type | Description |
|------|-------------|
| \`none\` | Fixed replicas (set \`replicas\` value) |
| \`hpa\` | Kubernetes-native HorizontalPodAutoscaler |
| \`keda\` | KEDA ScaledObject (manages HPA internally) |

When \`autoscaling.type\` is \`hpa\` or \`keda\`, setting \`replicas\` will cause a template error to prevent conflicts.

## Argo Rollouts

Set \`rollout.enabled: true\` to create a Rollout resource that references the Deployment via \`workloadRef\`. The HPA/KEDA \`scaleTargetRef\` automatically switches to target the Rollout.

\`rollout.strategy\` is required when enabled.

## Graceful shutdown

The chart auto-generates \`terminationGracePeriodSeconds\` and a preStop hook:

\`\`\`
|-- terminationGracePeriodSeconds (drain + app) --|
|-- preStop sleep (drain) --|-- app shutdown ------|
                             ^
                          SIGTERM
\`\`\`

The preStop sleep holds the container alive while the load balancer finishes deregistering the Pod.

## Examples

See [\`examples/\`](examples/) for values files covering common patterns:

| File | Pattern |
|------|---------|
| \`deployment.yaml\` | Basic deployment with fixed replicas |
| \`deployment-hpa.yaml\` | HPA autoscaling |
| \`deployment-ingress.yaml\` | Ingress with ALB |
| \`deployment-keda.yaml\` | KEDA autoscaling |
| \`deployment-rollout.yaml\` | Argo Rollouts canary |

## Lint & test

\`\`\`sh
make lint           # lint all examples
make test           # deploy + helm test (requires cluster)
\`\`\`
