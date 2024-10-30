function Set-SalesItemField{
    [CmdletBinding()]
    param (
        [Parameter()][string]$IssueRepoHost = $global:SALES_PROJECT_HOST,
        [Parameter()][string]$IssueRepo = $global:SALES_ISSUES_REPO,
        [Parameter()][string]$IssueRepoOwner = $global:SALES_ISSUES_OWNER,
        [Parameter(Mandatory,Position=0)][int]$IssueNumber,
        [Parameter(Mandatory,Position=1)][string]$FieldName,
        [Parameter(Mandatory,Position=2)][string]$Value,
        [Parameter()][switch]$Force
        
    )

    $url = "https://$IssueRepoHost/$IssueRepoOwner/$IssueRepo/issues/$IssueNumber"

    $prj = Get-SalesProject -Force:$Force

    $param = @{
        ProjectV2 = $prj
        FieldName = $FieldName
        Value = $Value
        Url = $url
    }

    Edit-ItemProjectV2 @param
} Export-ModuleMember -Function Set-SalesItemField

function Set-SalesItemFieldStatus{
    [CmdletBinding()]
    [Alias("setFieldStatus")]
    param (

        [Parameter(Mandatory, Position=0)][int]$IssueNumber,
        [Parameter(Mandatory, Position=1)]
        [ValidateSet("Todo", "In Progress", "ActionRequired", "Waiting","Planned","Done")]
        [string]$Value
    )

    $params = @{
        IssueNumber = $IssueNumber
        FieldName = "Status"
        Value = $Value
    }

    Set-SalesItemField @params
} Export-ModuleMember -Function Set-SalesItemFieldStatus -Alias setFieldStatus

function Set-SalesItemFieldComment{
    [CmdletBinding()]
    [Alias("setFieldComment")]
    param (

        [Parameter(Mandatory, Position=0)][int]$IssueNumber,
        [Parameter(Mandatory, Position=1)][string]$Value
    )

    $params = @{
        IssueNumber = $IssueNumber
        FieldName = "Comment"
        Value = $Value
    }

    Set-SalesItemField @params
} Export-ModuleMember -Function Set-SalesItemFieldComment -Alias setFieldComment
function Set-SalesItemFieldFullStatus{
    [CmdletBinding()]
    [Alias("setFieldFullStatus","sffs")]
    param (

        [Parameter(Mandatory, Position=0)][int]$IssueNumber,
        [Parameter(Mandatory, Position=1)]
        [ValidateSet("Todo", "In Progress", "ActionRequired", "Waiting","Planned","Done")]
        [string]$IssueStatus,
        [Parameter(Mandatory,Position=2)] [string]$FieldComment,
        [Parameter(Mandatory,Position=3)] [string]$ItemComment
    )

    Set-SalesItemFieldStatus -IssueNumber $IssueNumber -Value $IssueStatus
    Set-SalesItemFieldComment -IssueNumber $IssueNumber -Value $FieldComment

    if ($ItemComment) {
        Add-SalesIssueComment -IssueNumber $IssueNumber -Comment $ItemComment
    }

} Export-ModuleMember -Function Set-SalesItemFieldFullStatus -Alias "setFieldFullStatus","sffs"

function Set-SalesProjectFieldMyType {
    [CmdletBinding()]
    [Alias("setFieldMyType")]
    param (
        [Parameter(Mandatory,Position=0)][int]$IssueNumber,
        [Parameter(Mandatory,Position=1)][string]$Value,
        [Parameter()][switch]$Force
    )

    $prj = Get-SalesProject -Force:$Force

    $field = $prj.fields.nodes | Where-Object {$_.name -eq "MyType"}
    $option = $field.options | Where-Object {$_.name -like "*$Value*"}

    $params = @{
        IssueNumber = $IssueNumber
        FieldName = "MyType"
        Value = $option.name
    }

    Set-SalesItemField @params

} Export-ModuleMember -Function Set-SalesProjectFieldMyType -Alias setFieldMyType

function Get-SalesProjectFieldValuesMyType{
    [CmdletBinding()]
    param (
        [switch]$Force
    )

    $prj = Get-SalesProject -Force:$Force

    $field = $prj.fields.nodes | Where-Object {$_.name -eq "MyType"}

    $options = $field.options | ForEach-Object {
        $_.name
    }

    return $options
} Export-ModuleMember -Function Get-SalesProjectFieldValuesMyType

function Search-SalesProjectItem {
    [CmdletBinding()]
    [Alias("searchItems")]
    param (
        [Parameter(Mandatory,Position=0)][string]$Query,
        [switch]$Force
    )

    $prj = Get-SalesProject -Force:$Force

    $items = $prj.items.nodes | Where-Object {$_.content.title -like "*$Query*"}

    $customObject = $items | ConvertFrom-ItemToCustomObject

    return $customObject

} Export-ModuleMember -Function Search-SalesProjectItem -Alias searchItems

#convert item to pscustomobject
function ConvertFrom-ItemToCustomObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)][object]$Node
    )

    process{
        $customObject = $Node | ForEach-Object {
            [PSCustomObject]@{
                MyType = (Get-ItemFieldValue -Node $_ -FieldName "MyType")
                Number = $_.content.number
                Status = (Get-ItemFieldValue -Node $_ -FieldName "Status")
                Title =  $_.content.title
                Comment = (Get-ItemFieldValue -Node $_ -FieldName "Comment")
                Repository = $_.content.repository.nameWithOwner
                
            }
        }
        return $customObject
    }
}