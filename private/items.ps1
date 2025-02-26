function Get-ItemFieldValue{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)][object]$Node,
        [Parameter(Mandatory)][string]$FieldName
    )

    process {
        $fieldvalue = $node.fieldValues.nodes | Where-Object {$_.field.name -eq $FieldName}

        # return empty if field name not listed
        if (-not $fieldvalue) {
            return ""
        }

        # Find the field value depending on tthe typename
        switch ($fieldvalue.__typename) {
            ProjectV2ItemFieldTextValue { $ret = $fieldvalue.text }
            ProjectV2ItemFieldSingleSelectValue {$ret = $fieldvalue.name}
            ProjectV2ItemFieldNumberValue {$ret = $fieldvalue.number}
            ProjectV2ItemFieldDateValue {$ret = $fieldvalue.date}
            ProjectV2ItemFieldIterationValue {$ret = $fieldvalue.title}
            Default {
                # Wait-Debugger
                throw "Field type $($fieldvalue.field.datatype) not supported"
            }
        }

        return $ret
    }
}