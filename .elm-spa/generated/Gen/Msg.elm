module Gen.Msg exposing (Msg(..))

import Gen.Params.Home_
import Gen.Params.Search
import Gen.Params.YourLibrary
import Gen.Params.NotFound
import Pages.Home_
import Pages.Search
import Pages.YourLibrary
import Pages.NotFound


type Msg
    = Home_ Pages.Home_.Msg
    | Search Pages.Search.Msg
    | YourLibrary Pages.YourLibrary.Msg

