{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elasticsearch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.fullname" -}}
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
Create a default fully qualified client name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.client.fullname" -}}
{{ template "elasticsearch.fullname" . }}-{{ .Values.client.name }}
{{- end -}}

{{/*
Create a default fully qualified data name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.data.fullname" -}}
{{ template "elasticsearch.fullname" . }}-{{ .Values.data.name }}
{{- end -}}

{{/*
Create a default fully qualified master name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.master.fullname" -}}
{{ template "elasticsearch.fullname" . }}-{{ .Values.master.name }}
{{- end -}}

{{/*
Create a default fully qualified master-data name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.master_data.fullname" -}}
{{ template "elasticsearch.fullname" . }}-{{ .Values.master_data.name }}
{{- end -}}

{{/*
Calculate expected master nodes count
*/}}
{{- define "elasticsearch.master_node.count" -}}
{{- if and .Values.master.enabled .Values.master_data.enabled -}}
{{ add .Values.master.replicas .Values.master_data.replicas . }}
{{- else if and .Values.master.enabled (not .Values.master_data.enabled) -}}
{{- .Values.master.replicas -}}
{{- else if and .Values.master_data.enabled (not .Values.master.enabled) -}}
{{- .Values.master_data.replicas -}}
{{- else -}}
0
{{- end -}}
{{- end -}}

{{/*
Calculate expected data nodes count
*/}}
{{- define "elasticsearch.data_node.count" -}}
{{- if and .Values.data.enabled .Values.master_data.enabled -}}
{{ add .Values.data.replicas .Values.master_data.replicas . }}
{{- else if and .Values.data.enabled (not .Values.master_data.enabled) -}}
{{- .Values.data.replicas -}}
{{- else if and .Values.master_data.enabled (not .Values.data.enabled) -}}
{{- .Values.master_data.replicas -}}
{{- else -}}
0
{{- end -}}
{{- end -}}

{{/*
Calculate minimum master nodes count
https://www.elastic.co/guide/en/elasticsearch/reference/current/discovery-settings.html
*/}}
{{- define "elasticsearch.master_node.mincount" -}}
{{- if and .Values.master.enabled .Values.master_data.enabled -}}
{{ add (div (add .Values.master.replicas .Values.master_data.replicas) 2) 1 }}
{{- else if and .Values.master.enabled (not .Values.master_data.enabled) -}}
{{ add (div .Values.master.replicas 2) 1 }}
{{- else if and .Values.master_data.enabled (not .Values.master.enabled) -}}
{{ add (div .Values.master_data.replicas 2) 1 }}
{{- else -}}
1
{{- end -}}
{{- end -}}
