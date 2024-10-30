
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

    $customObject = $items | ConvertFrom-ClientItemToCustomObject

    return $customObject

} Export-ModuleMember -Function Get-SalesProjectItemClients -Alias clients

function ConvertFrom-ClientItemToCustomObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)][object]$Node
    )

    process{
        $customObject = $Node | ForEach-Object {
            [PSCustomObject]@{
                Number = $_.content.number
                Status = (Get-ItemFieldValue -Node $_ -FieldName "Status")
                Title =  $_.content.title
                Comment = (Get-ItemFieldValue -Node $_ -FieldName "Comment")
            }
        }
        return $customObject
    }
}
