function New-SalesIssue {
    param (
        [string]$IssueTitle,
        [string]$Repo,
        [string]$Owner,
        [string]$IssueBody,
        [switch]$OpenOnCreation
    )
    
    $Owner, $Repo = Resolve-SalesOwnerAndRepo -Owner:$Owner -Repo:$Repo

    if (-not $IssueBody) {
        $IssueBody = ""
    } 

    $command = 'gh issue create --title "{title}" --repo {owner}/{repo} --body "{body}" --assignee "@me" --label "client"'
    $command = $command -replace "{owner}", $Owner
    $command = $command -replace "{repo}", $Repo
    $command = $command -replace "{title}", $IssueTitle
    $command = $command -replace "{body}", $IssueBody

    $url = Invoke-Expression $command

    if ($OpenOnCreation) {
        Open-UrlInBrowser -Url $url
    }

    return $url

} Export-ModuleMember -Function New-SalesIssue

function Get-SalesIssue{
    [CmdletBinding()]
    [Alias("getIssue")]
    param (
        [Parameter(Mandatory,Position=0)][int]$IssueNumber,
        [Parameter()][switch]$Web,
        [Parameter()][switch]$Force
    )

    $prj = Get-SalesProject -Force:$Force

    $item = $prj.items.nodes | Where-Object {$_.content.number -eq $IssueNumber}

    if ($Web) {
        $url = $item.content.url
        Open-UrlInBrowser -Url $url
        return
    }

    $co = ConvertFrom-ItemToCustomObject -Node $item

    return $co
} Export-ModuleMember -Function Get-SalesIssue -Alias getIssue

function Add-SalesIssueComment {
    [CmdletBinding()]
    [Alias("addIssueComment")]
    param (
        [Parameter(Mandatory,Position=0)][int]$IssueNumber,
        [Parameter(Mandatory,Position=1)][string]$Comment,
        [string]$Repo,
        [string]$Owner,
        [switch]$OpenOnCreation
    )

    $Owner, $Repo = Resolve-SalesOwnerAndRepo -Owner:$Owner -Repo:$Repo

    $command = 'gh issue comment $IssueNumber --repo {owner}/{repo} --body "{comment}"'
    $command = $command -replace "{comment}", $Comment
    $command = $command -replace "{owner}", $Owner
    $command = $command -replace "{repo}", $Repo

    $url = Invoke-Expression $command

    if ($OpenOnCreation) {
        Open-UrlInBrowser -Url $url
    }

    return $url

} Export-ModuleMember -Function Add-SalesIssueComment -Alias addIssueComment

function Edit-SalesIssueTitle {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)][int]$IssueNumber,
        [Parameter(Mandatory,Position=1)][string]$NewTitle,
        [string]$Repo,
        [string]$Owner,
        [switch]$OpenOnCreation
    )

    $Owner, $Repo = Resolve-SalesOwnerAndRepo -Owner:$Owner -Repo:$Repo

    $command = 'gh issue edit $IssueNumber --repo {owner}/{repo} --title "{newtitle}"'
    $command = $command -replace "{newtitle}", $NewTitle
    $command = $command -replace "{owner}", $Owner
    $command = $command -replace "{repo}", $Repo

    $url = Invoke-Expression $command

    if ($OpenOnCreation) {
        Open-UrlInBrowser -Url $url
    }

    return $url
} Export-ModuleMember -Function Edit-SalesIssueTitle
