{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "aws-ebs-csi-driver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aws-ebs-csi-driver.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aws-ebs-csi-driver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "aws-ebs-csi-driver.labels" -}}
helm.sh/chart: {{ include "aws-ebs-csi-driver.chart" . }}
{{ include "aws-ebs-csi-driver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "aws-ebs-csi-driver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aws-ebs-csi-driver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Controller labels
*/}}
{{- define "aws-ebs-csi-driver.controller.labels" -}}
helm.sh/chart: {{ include "aws-ebs-csi-driver.chart" . }}
{{ include "aws-ebs-csi-driver.controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Controller selector labels
*/}}
{{- define "aws-ebs-csi-driver.controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aws-ebs-csi-driver.name" . }}-controller
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
node labels
*/}}
{{- define "aws-ebs-csi-driver.node.labels" -}}
helm.sh/chart: {{ include "aws-ebs-csi-driver.chart" . }}
{{ include "aws-ebs-csi-driver.node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
node selector labels
*/}}
{{- define "aws-ebs-csi-driver.node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aws-ebs-csi-driver.name" . }}-node
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
snapshot controller labels
*/}}
{{- define "aws-ebs-csi-driver.snapshotController.labels" -}}
helm.sh/chart: {{ include "aws-ebs-csi-driver.chart" . }}
{{ include "aws-ebs-csi-driver.snapshotController.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
snapshot selector labels
*/}}
{{- define "aws-ebs-csi-driver.snapshotController.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aws-ebs-csi-driver.name" . }}-snapshot-controller
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Convert the `--extra-volume-tags` command line arg from a map.
*/}}
{{- define "aws-ebs-csi-driver.extra-volume-tags" -}}
{{- $result := dict "pairs" (list) -}}
{{- range $key, $value := .Values.extraVolumeTags -}}
{{- $noop := printf "%s=%s" $key $value | append $result.pairs | set $result "pairs" -}}
{{- end -}}
{{- if gt (len $result.pairs) 0 -}}
{{- printf "%s=%s" "- --extra-volume-tags" (join "," $result.pairs) -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "aws-ebs-csi-driver.controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
{{ default (printf "%s-controller" (include "aws-ebs-csi-driver.fullname" . )) .Values.controller.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "aws-ebs-csi-driver.node.serviceAccountName" -}}
{{- if .Values.node.serviceAccount.create -}}
{{ default (printf "%s-node" (include "aws-ebs-csi-driver.fullname" . )) .Values.node.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.node.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "aws-ebs-csi-driver.snapshotController.serviceAccountName" -}}
{{- if .Values.snapshotController.serviceAccount.create -}}
{{ default (printf "%s-snapshot-controller" (include "aws-ebs-csi-driver.fullname" . )) .Values.snapshotController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.snapshotController.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return secret name to be used based on provided values.
*/}}
{{- define "aws-ebs-csi-driver.controller.awsEnvSecretName" -}}
{{- if not .Values.controller.awsEnv.secret.existingSecretName -}}
{{ default (printf "%s-controller-aws-secret" (include "aws-ebs-csi-driver.fullname" . )) }}
{{- else -}}
    {{ .Values.controller.awsEnv.secret.existingSecretName }}
{{- end -}}
{{- end -}}

{{/*
Return secret name to be used based on provided values.
*/}}
{{- define "aws-ebs-csi-driver.snapshotController.awsEnvSecretName" -}}
{{- if not .Values.snapshotController.awsEnv.secret.existingSecretName -}}
{{ default (printf "%s-snapshot-controller-aws-secret" (include "aws-ebs-csi-driver.fullname" . )) }}
{{- else -}}
{{ .Values.snapshotController.awsEnv.secret.existingSecretName }}
{{- end -}}
{{- end -}}
