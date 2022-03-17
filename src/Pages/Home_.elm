module Pages.Home_ exposing (Model, Msg, page)

import Components.Svg as Svg
import Gen.Params.Home_ exposing (Params)
import Gen.Route as Route
import Html exposing (Html, button, div, h3, h4, h5, h6, header, img, li, p, section, small, strong, text, ul)
import Html.Attributes exposing (alt, attribute, class, id, src, style)
import List exposing (repeat)
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
    { title = "Spotify - Home"
    , body =
        UI.layout
            { defaultConfig
                | route = Route.Home_
                , mainTagContent =
                    [ viewMainPlaylist model
                    , viewPlaylist model
                    ]
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
        , List.map
            (\( photo, album ) ->
                div [ class "playlist__wrapper" ]
                    [ img
                        [ class "playlist__wrapper__img"
                        , src <| "https://picsum.photos/5" ++ String.fromInt (10 * photo)
                        , alt <| "Album Photo of " ++ album
                        ]
                        []
                    , h5 [ class "playlist__wrapper__album-name" ] [ text album ]
                    , button [ class "playlist__wrapper__player" ] [ Svg.play Svg.Playing ]
                    ]
            )
            [ ( 1, "Liked Songs" )
            , ( 2, "Mix Daily 1" )
            , ( 3, "Mix Daily 2" )
            , ( 4, "Mix Daily 3" )
            , ( 5, "Mix Daily 4" )
            , ( 6, "Mix Daily 5" )
            ]
            |> div [ class "playlist" ]
        ]


viewPlaylist : Model -> Html Msg
viewPlaylist model =
    section [ class "playlist-cards" ]
        [ ul [ class "playlist-cards__list--vertical" ] <|
            List.map
                (\x ->
                    li [ class "playlist-cards__list--vertical__item" ]
                        [ h6 [ class "playlist-cards__list--vertical__item__heading" ]
                            [ text "Shows you might like" ]
                        , button [ class "playlist-cards__list--vertical__item__more" ]
                            [ small [] [ text "SEE ALL" ] ]
                        , ul [ class "playlist-cards__list--horizontal" ] <| viewPlaylistCards x
                        ]
                )
                [ 0, 1, 2, 3, 4, 6, 7, 8, 9 ]
        ]


viewPlaylistCards : Int -> List (Html msg)
viewPlaylistCards vertical =
    List.map
        (\x ->
            li [ class "item" ]
                [ div [ class "item__container" ]
                    [ img
                        [ class "item__container__img"
                        , "https://picsum.photos/3"
                            ++ String.fromInt (x * (10 + vertical))
                            |> src
                        , alt "Album Photo"
                        ]
                        []
                    , button [ class "item__container__btm" ]
                        [ Svg.play Svg.Playing ]
                    ]
                , strong [ class "item__album-info--name" ] [ text "Daily Mix 1" ]
                , p [ class "item__album-info--author" ]
                    [ text "Johann Gonçalves Pereiras" ]
                ]
        )
        [ 1, 2, 3, 4, 5, 6, 7 ]
