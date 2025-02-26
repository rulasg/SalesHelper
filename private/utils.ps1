function Open-UrlInBrowser {
    param (
        [string]$Url
    )

    if ($IsWindows) {
        Start-Process $Url
    } elseif ($IsLinux) {
        xdg-open $Url
    } elseif ($IsMacOS) {
        open $Url
    } else {
        Write-Error "Unsupported OS"
    }
}

function Get-UserProfilePath {
    if ($IsWindows) {
        return [System.Environment]::GetFolderPath('UserProfile')
    } elseif ($IsMacOS -or $IsLinux) {
        return $HOME
    } else {
        Write-Error "Unsupported OS"
    }
}