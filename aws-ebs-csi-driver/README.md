
Aws-ebs-csi-driver
===========

A Helm chart for AWS EBS CSI Driver.

CSI Document: https://kubernetes-csi.github.io/docs/introduction.html

## TL;DR:

```bash
helm repo add chatwork https://chatwork.github.io/charts
helm install chatwork/aws-ebs-csi-driver aws-ebs-csi-driver
```

This application cannot be launched without AWS privileges.

https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json

## Configuration

The following table lists the configurable parameters of the Aws-ebs-csi-driver chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `image.repository` | Image repository aws-ebs-csi-driver(controller, node) | `"amazon/aws-ebs-csi-driver"` |
| `image.tag` | Image tag aws-ebs-csi-driver | `"v0.7.0"` |
| `image.pullPolicy` | Image pull policy for aws-ebs-csi-driver | `"IfNotPresent"` |
| `imagePullSecrets` | Image Pull Secrets for aws-ebs-csi-driver | `[]` |
| `enableVolumeScheduling` | If true, enable volume scheduling for dynamic volume provisioning  | `false` |
| `enableVolumeResizing` | If true, enable volume resizing    | `false` |
| `enableVolumeSnapshot` | If true, enable volume snapshot    | `false` |
| `extraVolumeTags` | Extra volume tags to attach to each dynamically provisioned volume. | `{}` |
| `region` | aws region | `""` |
| `csiProvisoner.image.repository` | Image repository  | `"quay.io/k8scsi/csi-provisioner"` |
| `csiProvisoner.image.tag` | Image tag   | `"v1.6.0"` |
| `csiProvisoner.image.pullPolicy` | Image pullPolicy  | `"Always"` |
| `csiProvisoner.resources` | Set resources   | `{}` |
| `csiProvisoner.leaderElection` | If true, enable leader-election | `true` |
| `csiProvisoner.logLevel` | Set log-level  | `5` |
| `csiProvisoner.extraArgs` | Set extraArgs https://github.com/kubernetes-csi/external-provisioner#command-line-options | `[]` |
| `csiAttacher.image.repository` | Image repository | `"quay.io/k8scsi/csi-attacher"` |
| `csiAttacher.image.tag` | Image tag  | `"v3.0.2"` |
| `csiAttacher.image.pullPolicy` | Image pullPolicy  | `"Always"` |
| `csiAttacher.resources` | Set resources  | `{}` |
| `csiAttacher.leaderElection` | if true, enable leader-election | `true` |
| `csiAttacher.logLevel` | Set log-level | `5` |
| `csiAttacher.extraArgs` | Set extraArgs https://github.com/kubernetes-csi/external-attacher#command-line-options | `[]` |
| `csiResizer.image.repository` | Image repository | `"quay.io/k8scsi/csi-resizer"` |
| `csiResizer.image.tag` | Image tag  | `"v1.0.1"` |
| `csiResizer.image.pullPolicy` | Image pullPolicy | `"Always"` |
| `csiResizer.resources` | Set resources  | `{}` |
| `csiResizer.logLevel` | Set log-level  | `5` |
| `csiResizer.extraArgs` | Set extraArgs https://github.com/kubernetes-csi/external-resizer#command-line-options | `[]` |
| `csiSnapshotter.image.repository` | Image repository | `"quay.io/k8scsi/csi-snapshotter"` |
| `csiSnapshotter.image.tag` | Image tag | `"v3.0.2"` |
| `csiSnapshotter.image.pullPolicy` | Image pullPolicy | `"Always"` |
| `csiSnapshotter.leaderElection` | If true, enable leader-election  | `true` |
| `csiSnapshotter.extraArgs` | Set extraArgs https://github.com/kubernetes-csi/external-snapshotter#snapshot-controller-command-line-options | `[]` |
| `csiSnapshotter.resources` | Set resources | `{}` |
| `livenessProbe.image.repository` | Set image repository  | `"quay.io/k8scsi/livenessprobe"` |
| `livenessProbe.image.tag` | Set image tag | `"v2.1.0"` |
| `livenessProbe.image.pullPolicy` | Set image pullPolicy  | `"Always"` |
| `livenessProbe.resources` | Set resources  | `{}` |
| `snapshotController.image.repository` | Image repository  | `"quay.io/k8scsi/snapshot-controller"` |
| `snapshotController.image.tag` | Image tag  | `"v3.0.0"` |
| `snapshotController.image.pullPolicy` | Image pullPolicy | `"IfNotPresent"` |
| `snapshotController.replicas` | Image replicas | `1` |
| `snapshotController.leaderElection` | If true, use leader-election  | `false` |
| `snapshotController.resources` | resources  | `{}` |
| `snapshotController.annotations` | annotations | `{}` |
| `snapshotController.podAnnotations` | pod annotations | `{}` |
| `snapshotController.logLevel` | log-level | `5` |
| `snapshotController.extraArgs` | extraArgs | `[]` |
| `snapshotController.serviceAccount.annotations` | serviceAccount annotations  | `{}` |
| `snapshotController.serviceAccount.create` | If true, serviceAccount created | `true` |
| `snapshotController.serviceAccount.name` | Service account to be used | `null` |
| `snapshotController.awsEnv.secret.existingSecretName` | Secret name to be used | `null` |
| `snapshotController.awsEnv.secret.keyId` | AWS_ACCESS_KEY_ID | `null` |
| `snapshotController.awsEnv.secret.accessKey` | AWS_SECRET_ACCESS_KEY | `null` |
| `snapshotController.extraEnv` | extra environment value | `null` |
| `nodeDriverRegistrar.image.repository` | Image repository | `"quay.io/k8scsi/csi-node-driver-registrar"` |
| `nodeDriverRegistrar.image.tag` | Image tag  | `"v2.0.1"` |
| `nodeDriverRegistrar.imagePullPolicy` | Image pullPolicy | `"Always"` |
| `nodeDriverRegistrar.resources` | Set resources  | `{}` |
| `nodeDriverRegistrar.extraArgs` | Set extraArgs https://github.com/kubernetes-csi/node-driver-registrar#optional-arguments | `[]` |
| `nodeDriverRegistrar.logLevel` | Set log-level | `5` |
| `node.annotations` | node plugin annotations | `{}` |
| `node.podAnnotations` | node plugin pod annotations | `{}` |
| `node.tolerations` | node plugin tolerations | `[]` |
| `node.logLevel` | node plugin log-level | `5` |
| `node.extraArgs` | node plugin extra args  | `[]` |
| `node.resources` | node plugin resources | ... |
| `node.updateStrategy` | node plugin updateStrategy | ... |
| `node.priorityClassName` | node plugin priorityClassName | `"system-node-critical"` |
| `controller.replicaCount` | controller replicaCount | `2` |
| `controller.serviceAccount.annotations` | controller plugin serviceAccount annotations  | `{}` |
| `controller.serviceAccount.create` | If true, controller plugin serviceAccount create | `true` |
| `controller.serviceAccount.name` | controller plugin service account to be used | `null` |
| `controller.awsEnv.secret.existingSecretName` | Secret name to be used | `null` |
| `controller.awsEnv.secret.keyId` | AWS_ACCESS_KEY_ID | `null` |
| `controller.awsEnv.secret.accessKey` | AWS_SECRET_ACCESS_KEY | `null` |
| `controller.extraEnv` | extra environment value | `null` |
| `controller.resources` | controller plugin resources | ... |
| `controller.nodeSelector` | controller plugin nodeSelector  | `{}` |
| `controller.tolerations` | controller plugin tolerations  | `[]` |
| `controller.affinity` | controller plugin affinity  | `{}` |
| `controller.annotations` | controller plugin annotations | `{}` |
| `controller.podAnnotations` | controller plugin pod annotations | `{}` |
| `controller.logLevel` | controller plugin log-level | `5` |
| `controller.extraArgs` | controller plugin extra args  | `[]` |

---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

