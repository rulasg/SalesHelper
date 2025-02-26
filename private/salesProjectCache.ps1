
$CacheFolderPath = Get-UserProfilePath | Join-Path -ChildPath ".helpers" -AdditionalChildPath "saleshelper"
$CacheFilePath = Join-Path -Path $CacheFolderPath -ChildPath "sales-project-cache.json"

# Ensure the .helpers directory exists
if (-not (Test-Path -Path $CacheFolderPath)) {
    New-Item -Path $CacheFolderPath -ItemType Directory | Out-Null
}

function Get-SalesProjectCache{

    return Read-CacheFile

} Export-ModuleMember -Function Get-SalesProjectCache

function Set-SalesProjectCache{
    [CmdletBinding()]
    param ([Parameter(Mandatory,Position=0)][object]$ProjectV2)

    Write-CacheFile -ProjectV2 $ProjectV2

} Export-ModuleMember -Function Set-SalesProjectCache

function Test-SalesProjectCache{
    return Test-CacheFile
} Export-ModuleMember -Function Test-SalesProjectCache

function Reset-SalesProjectCache{
    Remove-CacheFile
} Export-ModuleMember -Function Reset-SalesProjectCache

function Write-CacheFile{
    [CmdletBinding()]
    param ([Parameter(Mandatory,Position=0)][object]$ProjectV2)

    $ProjectV2 | ConvertTo-Json -Depth 10 | Set-Content -Path $CacheFilePath
} Export-ModuleMember -Function Write-CacheFile

function Read-CacheFile{
    return Get-Content -Path $CacheFilePath | ConvertFrom-Json -Depth 10
} Export-ModuleMember -Function Read-CacheFile

function Remove-CacheFile{
    if (Test-Path -Path $CacheFilePath) {
        Remove-Item -Path $CacheFilePath -Force
    }
} Export-ModuleMember -Function Delete-CacheFile

function Test-CacheFile{
    return Test-Path -Path $CacheFilePath
} Export-ModuleMember -Function Test-CacheFile