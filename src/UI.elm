module UI exposing (Model, defaultConfig, layout)

import Components.Svg as Svg
import Gen.Route as Route exposing (Route)
import Html exposing (Attribute, Html, a, div, header, main_, nav, section, text)
import Html.Attributes exposing (attribute, class, classList, href, id)



-- Model


type alias Model msg =
    { route : Route
    , mainTagContent : List (Html msg)
    , mainTagAttrs : List (Attribute msg)
    , playerTagContent : List (Html msg)
    , playingMusicName : String
    }


type alias Link =
    { routeStatic : Route
    , routeReceived : Route
    , routeName : String
    }


defaultConfig : Model msg
defaultConfig =
    { route = Route.Home_
    , mainTagContent = []
    , mainTagAttrs = []
    , playerTagContent = []
    , playingMusicName = ""
    }


defaultLink : Link
defaultLink =
    { routeStatic = Route.Home_
    , routeReceived = Route.Home_
    , routeName = ""
    }



-- Structure


isRoute : Route -> Route -> Bool
isRoute route compare =
    case ( route, compare ) of
        ( Route.Home_, Route.Home_ ) ->
            True

        ( Route.Search, Route.Search ) ->
            True

        ( Route.YourLibrary, Route.YourLibrary ) ->
            True

        _ ->
            False


caseNamePage : Route -> String
caseNamePage route =
    case route of
        Route.Home_ ->
            "Home"

        Route.Search ->
            "Search"

        Route.YourLibrary ->
            "Your Library"

        Route.NotFound ->
            "Not Found"



-- View


viewLink : Link -> Html msg
viewLink model =
    a
        [ href <| Route.toHref model.routeStatic
        , class "main-header__links"
        , classList
            [ ( "main-header__links--current-page"
              , isRoute model.routeReceived model.routeStatic
              )
            ]
        ]
        [ text model.routeName ]


layout : Model msg -> List (Html msg)
layout model =
    let
        mainClass : Attribute msg
        mainClass =
            class <| "main--" ++ caseNamePage model.route
    in
    [ div
        [ id "root"
        , classList [ ( "scroll", True ), ( "root--" ++ caseNamePage model.route, True ) ]
        ]
        [ viewHeader model
        , main_ (mainClass :: model.mainTagAttrs) model.mainTagContent
        , section [ class "player", attribute "aria-labelledby" model.playingMusicName ] model.playerTagContent
        ]
    ]


viewHeader : Model msg -> Html msg
viewHeader model =
    header [ class "main-header" ]
        [ Svg.spotify Svg.Robust
        , nav
            [ class "main-header__nav" ]
            [ viewLink
                { defaultLink
                    | routeName = caseNamePage Route.Home_
                    , routeStatic = Route.Home_
                    , routeReceived = model.route
                }
            , viewLink
                { defaultLink
                    | routeName = caseNamePage Route.Search
                    , routeStatic = Route.Search
                    , routeReceived = model.route
                }
            , viewLink
                { defaultLink
                    | routeName = caseNamePage Route.YourLibrary
                    , routeStatic = Route.YourLibrary
                    , routeReceived = model.route
                }
            ]
        ]
