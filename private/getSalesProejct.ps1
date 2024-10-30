

$PSScriptRoot | Split-Path -Parent | Split-Path -Parent | Join-Path -ChildPath "project-migration" | Import-Module -Force -Global


# $SALES_PROJECT_NUBMERS = 9279
# $SALES_PROJECT_OWNER = "github"
# $SALES_PROJECT_HOST = "github.com"

function Get-SalesProject{
    [CmdletBinding()]
    param (
        [string]$ProjectHost = $SALES_PROJECT_HOST,
        [string]$ProjectOwner = $SALES_PROJECT_OWNER,
        [string]$ProjectNumber = $SALES_PROJECT_NUBMERS,
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
