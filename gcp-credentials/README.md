This chart creates a secret for credential of gcp.

GCP credentials needs file to a specific path(https://cloud.google.com/logging/docs/agent/authorization).

If you use secret created by this chart, please follow setting in your manifest.

```
# sample manifest
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: redis
    volumeMounts:
    - mountPath: /etc/google/auth/
      name: gcp-credentials
      readOnly: true
  volumes:
  - name: gcp-credentials
    secret:
      secretName: gcp-credentials
```
