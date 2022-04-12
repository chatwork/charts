{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "postfix.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postfix.fullname" -}}
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
{{- define "postfix.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "postfix.labels" -}}
helm.sh/chart: {{ include "postfix.chart" . }}
{{ include "postfix.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "postfix-mailcatcher.labels" -}}
helm.sh/chart: {{ include "postfix.chart" . }}
{{ include "postfix-mailcatcher.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "postfix.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postfix.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "postfix-mailcatcher.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postfix.name" . }}-mailcatcher
app.kubernetes.io/instance: {{ .Release.Name }}-mailcatcher
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "postfix.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "postfix.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return true if we can enable Service Internal Traffic Policy
*/}}
{{- define "enable-service-internal-traffic-policy" -}}
{{- if and (semverCompare "^1.22-0" .Capabilities.KubeVersion.GitVersion) .Values.daemonset.enabled -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
