module Gen.Model exposing (Model(..))

import Gen.Params.Home_
import Gen.Params.Search
import Gen.Params.YourLibrary
import Gen.Params.NotFound
import Pages.Home_
import Pages.Search
import Pages.YourLibrary
import Pages.NotFound


type Model
    = Redirecting_
    | Home_ Gen.Params.Home_.Params Pages.Home_.Model
    | Search Gen.Params.Search.Params Pages.Search.Model
    | YourLibrary Gen.Params.YourLibrary.Params Pages.YourLibrary.Model
    | NotFound Gen.Params.NotFound.Params

