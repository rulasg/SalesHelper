function Test_GetDefaultRepo_Empty {

    $reulstOwner,$resultRepo = Get-SalesDefaultRepo

    Assert-AreEqual -Presented $reulstOwner -Expected "github" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "sales" -Comment "The default repo is sales"

}

function Test_GetDefaultRepo_WhiteSpaces {

    $reulstOwner,$resultRepo = Get-SalesDefaultRepo -Owner "   " -Repo "   "

    Assert-AreEqual -Presented $reulstOwner -Expected "github" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "sales" -Comment "The default repo is sales"

}