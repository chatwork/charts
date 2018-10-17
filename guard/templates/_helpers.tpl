{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "guard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "guard.fullname" -}}
{{- $name := default .Chart.Name .Values.fullNameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for Deployment APIs.
*/}}
{{- define "deployment.apiVersion" -}}
{{- if semverCompare ">=1.9.0" .Capabilities.KubeVersion.GitVersion -}}
"apps/v1"
{{- else if semverCompare ">=1.8.0" .Capabilities.KubeVersion.GitVersion -}}
"apps/v1beta2"
{{- else -}}
"apps/v1beta1"
{{- end -}}
{{- end -}}
