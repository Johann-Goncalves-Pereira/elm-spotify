module Pages.Home_ exposing (Model, Msg, page)

import Components.Svg as Svg
import Gen.Params.Home_ exposing (Params)
import Gen.Route as Route
import Html exposing (Html, button, div, h3, h4, h5, header, img, p, section, text)
import Html.Attributes exposing (alt, attribute, class, id, src, style)
import Page
import Request
import Shared
import Tuple exposing (second)
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
    { title = "Spotify - Home"
    , body =
        UI.layout
            { defaultConfig
                | route = Route.Home_
                , mainTagContent =
                    [ viewMainPlaylist model ]
            }
    }


viewMainPlaylist : Model -> Html Msg
viewMainPlaylist model =
    section
        [ class "main-playlist"
        , attribute "aria-labelledby" "main-playlist-heading"
        ]
        [ header [ class "header" ]
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
        , h4 [ class "main-playlist__heading" ] [ text "Good afternoon" ]
        , List.repeat 6 ( "https://picsum.photos/500", "Liked Songs" )
            |> List.map
                (\( photo, album ) ->
                    div [ class "playlist__wrapper" ]
                        [ img
                            [ class "playlist__wrapper__img"
                            , src photo
                            , alt <| "Album Photo of " ++ album
                            ]
                            []
                        , h5 [ class "playlist__wrapper__album-name" ] [ text album ]
                        , button [ class "playlist__wrapper__player" ] [ Svg.play Svg.Playing ]
                        ]
                )
            |> div [ class "playlist" ]
        ]
