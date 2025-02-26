function Get-SalesDefaultRepo
{
    [CmdletBinding()]
    param (
        [string]$Repo = $DEFAULT_REPO,
        [string]$Owner = $DEFAULT_OWNER
    )

    $Repo = [string]::IsNullOrWhiteSpace($Repo) ?  $DEFAULT_REPO :  $Repo 
    $Owner = [string]::IsNullOrWhiteSpace($Owner) ?  $DEFAULT_OWNER :  $Owner

    return $Owner, $Repo

} Export-ModuleMember -Function Get-SalesDefaultRepo
