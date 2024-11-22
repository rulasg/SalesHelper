
function Get-SalesProjectItemClients {
    [CmdletBinding()]
    [Alias("clients")]
    param (
        [switch]$ActionRequired,
        [switch]$Force
    )

    $prj = Get-SalesProject -Force:$Force

    $items = $prj.items.nodes | Where-Object {
        (Get-ItemFieldValue -Node $_ -FieldName "MyType") -Like "*Client*"
    }

    if ($ActionRequired) {
        $items = $items | Where-Object {
            (Get-ItemFieldValue -Node $_ -FieldName "Status") -eq "ActionRequired"
        }
    }

    $customObject = $items | ConvertFrom-ItemToCustomObject

    return $customObject

} Export-ModuleMember -Function Get-SalesProjectItemClients -Alias clients


