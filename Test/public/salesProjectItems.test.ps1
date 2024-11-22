function Test_ProjectSalesItems {

    $prj = GetMockProject
    Set-SalesProjectCache $prj

    $items = Get-SalesProjectItem

    Assert-Count -Expected 43 -Presented $items
}

function Test_ProjectSalesItems_WithActionRequired {

    $prj = GetMockProject
    Set-SalesProjectCache $prj

    $items = Get-SalesProjectItem -ActionRequired

    Assert-Count -Expected 13 -Presented $items
}

function Test_ProjectSalesItems_Includedone {

    $prj = GetMockProject
    Set-SalesProjectCache $prj

    $items = Get-SalesProjectItem -IncludeDone

    Assert-Count -Expected 65 -Presented $items
}


