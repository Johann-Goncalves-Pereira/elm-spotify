module Pages.Search exposing (Model, Msg, page)

import Components.Svg as Svg
import Gen.Params.Home_ exposing (Params)
import Gen.Route as Route
import Html exposing (Html, button, div, h3, header, img, p, text)
import Html.Attributes exposing (alt, class, id, src)
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
    { title = "Spotify - Search"
    , body =
        UI.layout
            { defaultConfig
                | route = Route.Search
                , mainTagContent =
                    [ p [] [ text "Search" ] ]
            }
    }


viewHeader : Model -> Html Msg
viewHeader model =
    header [ class "header" ]
        [ div [ class "header__btm-ctnr" ]
            [ button [ class "header__btm-ctnr__arrows" ] [ Svg.arrowLine ]
            , button [ class "header__btm-ctnr__arrows" ] [ Svg.arrowLine ]
            ]
        , button
            [ class "header__user-ctnr" ]
            [ img [ class "header__user-ctnr__img", src "https://picsum.photos/300", alt "User Photo" ] []
            , h3 [ class "header__user-ctnr__heading", id "main-playlist-heading" ] [ text "Johann Gonçalves Pereira" ]
            , Svg.arrowFull
            ]
        ]
