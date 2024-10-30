function Test_ProjectItemClients {

    $prj = GetMockProject
    Set-SalesProjectCache $prj

    $items = Get-SalesProjectItemClients

    Assert-Count -Expected 17 -Presented $items
}

function Test_ProjectItemClients_WithActionRequired {

    $prj = GetMockProject
    Set-SalesProjectCache $prj

    $items = Get-SalesProjectItemClients -ActionRequired

    Assert-Count -Expected 8 -Presented $items
}



function GetMockProject{
    $local = $PSScriptRoot
    $dataPath = $local | Join-Path -ChildPath "data" -AdditionalChildPath "projectV2.json"
    $data = Get-Content -Path $dataPath -Raw | ConvertFrom-Json -Depth 10

    return $data
}