function Test_ResolveOwnerAndRepo_Empty {

    . $TARGET_MODULE_PATH/private/defaultRepo/resolveOwnerAndRepo.ps1

    $reulstOwner,$resultRepo = Resolve-SalesOwnerAndRepo

    Assert-AreEqual -Presented $reulstOwner -Expected "github" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "sales" -Comment "The default repo is sales"

}

function Test_ResolveOwnerAndRepo_WhiteSpaces {

    . $TARGET_MODULE_PATH/private/defaultRepo/resolveOwnerAndRepo.ps1

    $reulstOwner,$resultRepo = Resolve-SalesOwnerAndRepo -Owner "   " -Repo "   "

    Assert-AreEqual -Presented $reulstOwner -Expected "github" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "sales" -Comment "The default repo is sales"

}

function Test_ResolveOwnerAndRepo_Names {

    . $TARGET_MODULE_PATH/private/defaultRepo/resolveOwnerAndRepo.ps1

    $reulstOwner,$resultRepo = Resolve-SalesOwnerAndRepo -Owner "owner1" -Repo "repo1"

    Assert-AreEqual -Presented $reulstOwner -Expected "owner1" -Comment "The default owner is github"
    Assert-AreEqual -Presented $resultRepo -Expected "repo1" -Comment "The default repo is sales"

}