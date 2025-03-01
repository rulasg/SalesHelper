function Test_ResolveOwnerAndRepo_Empty {

    $reulstOwner,$resultRepo = Resolve-SalesOwnerAndRepo

    Assert-AreEqual -Presented $reulstOwner -Expected "github" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "sales" -Comment "The default repo is sales"

}

function Test_ResolveOwnerAndRepo_WhiteSpaces {

    $reulstOwner,$resultRepo = Resolve-SalesOwnerAndRepo -Owner "   " -Repo "   "

    Assert-AreEqual -Presented $reulstOwner -Expected "github" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "sales" -Comment "The default repo is sales"

}

function Test_ResolveOwnerAndRepo_Names {

    $reulstOwner,$resultRepo = Resolve-SalesOwnerAndRepo -Owner "owner1" -Repo "repo1"

    Assert-AreEqual -Presented $reulstOwner -Expected "owner1" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "repo1" -Comment "The default repo is sales"

}