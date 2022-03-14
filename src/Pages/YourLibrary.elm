module Pages.YourLibrary exposing (Model, Msg, page)

import Gen.Params.YourLibrary exposing (Params)
import Gen.Route as Route exposing (Route(..))
import Html exposing (p, text)
import Page
import Request
import Shared
import UI exposing (defaultConfig)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> Model
update msg model =
    case msg of
        ReplaceMe ->
            model



-- VIEW


view : Model -> View Msg
view model =
    { title = "Spotify - Your Library"
    , body =
        UI.layout
            { defaultConfig
                | route = Route.YourLibrary
                , mainTagContent =
                    [ p [] [ text "Your Library" ] ]
            }
    }
