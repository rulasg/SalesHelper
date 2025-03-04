
# TODO: remove dependecy with project-migration

function Import-ProjectHelper{
    [CmdletBinding()]
    param ()

    # Check if dependency is already available in the system. If so Load the module.
    if (Get-Module -Name ProjectHelper -ListAvailable){
        "Found ProjectHelper in the system. Loading it." | Write-Verbose
        Import-Module -Name ProjectHelper -Force
    }

    # Check if the module is loaded
    if (Get-Module -Name ProjectHelper){
        "ProjectHelper is loaded." | Write-Verbose
        return
    }

    # Module not loaded.
    "ProjectHelper module NOT loaded." | Write-Verbose

    # Check if its available side by side. Is not cline.
    $projectHelperFolder = $MODULE_PATH | Split-Path -Parent | Join-Path -ChildPath "ProjectHelper"
    if (-Not ($projectHelperFolder | Test-Path)){
        "ProjectHelper not found side by side. Cloning it." | Write-Verbose
        gh repo clone rulasg/ProjectHelper $projectHelperFolder

        # TODO: remove this. This is a workaround to get the correct branch
        Write-Host "Checking out rulasg/issue75" -ForegroundColor Red
        git -C $projectHelperFolder checkout "rulasg/issue75" }

    # Load Side by side module
    "Loading ProjectHelper from $projectHelperFolder" | Write-Verbose
    $projectHelperFolder | Import-Module 
} Export-ModuleMember -Function Import-ProjectHelper

function Get-SalesProject{
    [CmdletBinding()]
    param (
        [string]$ProjectHost = $global:SALES_PROJECT_HOST,
        [string]$ProjectOwner = $global:SALES_PROJECT_OWNER,
        [string]$ProjectNumber = $global:SALES_PROJECT_NUMBER,
        [switch]$Force
    )

    Import-ProjectHelper

    if (! (Test-SalesProjectCache) -or $Force) {
        $prj = Get-Project -Owner $ProjectOwner -ProjectNumber $ProjectNumber
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
