

$PSScriptRoot | Split-Path -Parent | Split-Path -Parent | Join-Path -ChildPath "project-migration" | Import-Module -Force -Global


function Get-SalesProject{
    [CmdletBinding()]
    param (
        [string]$ProjectHost = $global:SALES_PROJECT_HOST,
        [string]$ProjectOwner = $global:SALES_PROJECT_OWNER,
        [string]$ProjectNumber = $global:SALES_PROJECT_NUMBER,
        [switch]$Force
    )

    if (! (Test-SalesProjectCache) -or $Force) {
        $prj = Get-ProjectV2 -Owner $ProjectOwner -ProjectNumber $ProjectNumber -ApiHost $ProjectHost
        Set-SalesProjectCache $prj
    }

    return Get-SalesProjectCache
} Export-ModuleMember -Function Get-SalesProject

function Open-SalesProject {
    [CmdletBinding()]
    [Alias("openClients")]
    param ()
    
    $prj = Get-SalesProject
    $url = $prj.url
    Open-UrlInBrowser -Url $url
} Export-ModuleMember -Function Open-SalesProject -Alias openClients
