function Get-ItemFieldValue{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][object]$Node,
        [Parameter(Mandatory)][string]$FieldName
    )

    $fieldvalue = $node.fieldValues.nodes | Where-Object {$_.field.name -eq $FieldName}

    if (-not $fieldvalue) {
        return ""
    }

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