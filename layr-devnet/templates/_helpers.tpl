{{- define "gethDeploymentName" -}}
{{ .Values.geth.name }}
{{- end -}}

{{- define "beaconChainName" -}}
{{ .Values.beaconChain.name }}
{{- end -}}

{{- define "validatorName" -}}
{{ .Values.validator.name }}
{{- end -}}

{{- define "formatEnvVarName" -}}
{{ regexReplaceAll "\\." . "_" | upper }}
{{- end -}}
