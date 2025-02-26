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

function Test_ProjectSalesItems_MyType{

    $prj = GetMockProject
    Set-SalesProjectCache $prj

    $result = Get-SalesProjectItem -MyType "🔵 Oportunity"
    Assert-Count -Expected 2 -Presented $result

    $result = Get-SalesProjectItem -MyType "🔵 Oportunity" -IncludeDone
    Assert-Count -Expected 3 -Presented $result

    $result = Get-SalesProjectItem -MyType "🔵 Oportunity" -ActionRequired
    Assert-Count -Expected 1 -Presented $result

}

