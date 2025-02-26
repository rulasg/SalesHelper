
function Get-SalesProjectItem {
    [CmdletBinding()]
    [Alias("items")]
    param (
        [Parameter(Position=0)][string]$Filter,
        [Parameter(Position=1)][string]$MyType,
        [Parameter()][switch]$ActionRequired,
        [Parameter()][switch]$Force,
        [Parameter()][switch]$IncludeDone

    )

    $prj = Get-SalesProject -Force:$Force


    # $items = $prj.items.nodes | Where-Object {
    #     (Get-ItemFieldValue -Node $_ -FieldName "MyType") -Like "*Client*"
    # }

    if($IncludeDone){
        $items = $prj.items.nodes
    } else {
        $items = $prj.items.nodes | Where-Object {
            (Get-ItemFieldValue -Node $_ -FieldName "Status") -ne "Done"
        }
    }

    if ($MyType) {
        $items = $items | Where-Object {
            $value = Get-ItemFieldValue -Node $_ -FieldName "MyType"
            $value -eq $MyType
        }
    }

    if ($Filter) {
        $items = $items | Where-Object {
            $_.content.title -Like "*$Filter*"
        }
    }

    if ($ActionRequired) {
        $items = $items | Where-Object {
            (Get-ItemFieldValue -Node $_ -FieldName "Status") -eq "ActionRequired"
        }
    }

    $customObject = $items | ConvertFrom-ItemToCustomObject

    $customObject = $customObject | Sort-Object -Property NCC

    return $customObject

} Export-ModuleMember -Function Get-SalesProjectItem -Alias items

