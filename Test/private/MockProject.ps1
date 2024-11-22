
function GetMockProject{
    $local = $PSScriptRoot
    $dataPath = $local | Join-Path -ChildPath "mocksData" -AdditionalChildPath "projectV2.json"
    $data = Get-Content -Path $dataPath -Raw | ConvertFrom-Json -Depth 10

    return $data
}