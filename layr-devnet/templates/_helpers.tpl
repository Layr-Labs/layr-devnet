{{- define "gethDeploymentName" -}}
{{ .Values.geth.name }}
{{- end -}}

{{- define "beaconChainName" -}}
{{ .Values.beaconChain.name }}
{{- end -}}

{{- define "formatEnvVarName" -}}
{{ regexReplaceAll "\\." . "_" | upper }}
{{- end -}}
