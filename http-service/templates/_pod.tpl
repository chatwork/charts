{{/*
Validate values shared by the workload (Deployment or Rollout).
Always rendered, whichever workload kind is emitted, so the checks run in both modes.
*/}}
{{- define "http-service.validate" -}}
{{- if .Values.datadog.enabled }}
{{- $_ := required "datadog.env is required when datadog.enabled is true" .Values.datadog.env }}
{{- $_ := required "datadog.service is required when datadog.enabled is true" .Values.datadog.service }}
{{- $_ := required "datadog.version is required when datadog.enabled is true" .Values.datadog.version }}
{{- end }}
{{- if not (has .Values.autoscaling.type (list "none" "hpa" "keda")) }}
{{- fail "autoscaling.type must be one of: none, hpa, keda" }}
{{- end }}
{{- if and (ne .Values.autoscaling.type "none") .Values.replicas }}
{{- fail "replicas should not be set when autoscaling.type is hpa or keda — the autoscaler manages replica count" }}
{{- end }}
{{- end }}

{{/*
Pod template shared by the Deployment and the Rollout.
Rendered at column 0; callers indent it with nindent.
*/}}
{{- define "http-service.podTemplate" -}}
{{- $root := . -}}
metadata:
  annotations:
    checksum/configmap: '{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}'
    checksum/secret: '{{ include (print $.Template.BasePath "/secret.yaml") . | sha256sum }}'
  {{- with .Values.pod.annotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "http-service.selectorLabels" . | nindent 4 }}
    {{- if .Values.datadog.enabled }}
    tags.datadoghq.com/env: {{ .Values.datadog.env }}
    tags.datadoghq.com/service: {{ .Values.datadog.service }}
    tags.datadoghq.com/version: {{ .Values.datadog.version | quote }}
    {{- end }}
    {{- with .Values.pod.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  {{- with .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.readinessGates }}
  readinessGates:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  serviceAccountName: {{ include "http-service.serviceAccountName" . }}
  {{- with .Values.pod.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.priorityClassName }}
  priorityClassName: {{ . }}
  {{- end }}
  {{- $drainSeconds := required "gracefulShutdown.trafficDrainSeconds is required" .Values.gracefulShutdown.trafficDrainSeconds }}
  {{- $appSeconds := required "gracefulShutdown.appShutdownTimeoutSeconds is required" .Values.gracefulShutdown.appShutdownTimeoutSeconds }}
  terminationGracePeriodSeconds: {{ add $drainSeconds $appSeconds }}
  {{- with .Values.topologySpreadConstraints }}
  topologySpreadConstraints:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.volumes }}
  volumes:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.extraPodSpec }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- if .Values.initContainers.enabled }}
  initContainers:
    {{- range $container := .Values.initContainers.containers }}
    - name: {{ include "http-service.fullname" $root }}-{{ $container.name }}
      image: {{ $container.image.repository }}:{{ $container.image.tag }}
      {{- with $container.image.pullPolicy }}
      imagePullPolicy: {{ . }}
      {{- end }}
      {{- with $container.command }}
      command:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $container.args }}
      args:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $container.workingDir }}
      workingDir: {{ . }}
      {{- end }}
      {{- with $container.env }}
      env:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $container.envFrom }}
      envFrom:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $container.volumeMounts }}
      volumeMounts:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- end }}
  {{- end }}
  containers:
    - name: {{ include "http-service.fullname" . }}
      image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      {{- with .Values.securityContext }}
      securityContext:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      ports:
        - containerPort: {{ .Values.containerPort }}
          protocol: TCP
      {{- with .Values.command }}
      command:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.args }}
      args:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.env }}
      env:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.envFrom }}
      envFrom:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      lifecycle:
        preStop:
          exec:
            command:
              - sleep
              - {{ $drainSeconds | quote }}
      {{- $startupProbe := required "startupProbe is required" .Values.startupProbe }}
      {{- $livenessProbe := required "livenessProbe is required" .Values.livenessProbe }}
      startupProbe:
        {{- toYaml $startupProbe | nindent 8 }}
      livenessProbe:
        {{- toYaml $livenessProbe | nindent 8 }}
      {{- with .Values.readinessProbe }}
      readinessProbe:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.resources }}
      resources:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.volumeMounts }}
      volumeMounts:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- with .Values.extraContainers }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
{{- end }}
