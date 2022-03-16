module UI exposing (Model, defaultConfig, layout)

import Components.Svg as Svg
import Gen.Route as Route exposing (Route)
import Html exposing (Attribute, Html, a, div, header, main_, nav, section, text)
import Html.Attributes exposing (attribute, class, classList, href, id)
import Regex



-- Model


type alias Model msg =
    { route : Route
    , mainTagContent : List (Html msg)
    , mainTagAttrs : List (Attribute msg)
    , playerTagContent : List (Html msg)
    , playingMusicName : String
    }


type alias Link msg =
    { routeStatic : Route
    , routeReceived : Route
    , routeName : String
    , svgLink : Maybe (Html msg)
    }


defaultConfig : Model msg
defaultConfig =
    { route = Route.Home_
    , mainTagContent = []
    , mainTagAttrs = []
    , playerTagContent = []
    , playingMusicName = "music"
    }


defaultLink : Link msg
defaultLink =
    { routeStatic = Route.Home_
    , routeReceived = Route.Home_
    , routeName = ""
    , svgLink = Nothing
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


userReplace : String -> (Regex.Match -> String) -> String -> String
userReplace userRegex replacer string =
    case Regex.fromString userRegex of
        Nothing ->
            string

        Just regex ->
            Regex.replace regex replacer string


machClass : String -> String
machClass string =
    userReplace "[ ]" (\_ -> "-") string
        |> String.toLower


viewLink : Link msg -> Html msg
viewLink model =
    a
        [ href <| Route.toHref model.routeStatic
        , classList
            [ ( "main-header__links", True )
            , ( "main-header__links--current-page"
              , isRoute model.routeReceived model.routeStatic
              )
            ]
        ]
        [ Maybe.withDefault (text "") model.svgLink
        , text model.routeName
        ]


layout : Model msg -> List (Html msg)
layout model =
    let
        mainClass : Attribute msg
        mainClass =
            classList
                [ ( "main-content", True )
                , ( "main--" ++ caseNamePage model.route, True )
                ]
    in
    [ div
        [ id "root"
        , classList [ ( "scroll", True ), ( "root--" ++ machClass (caseNamePage model.route), True ) ]
        ]
        [ viewHeader model
        , main_ (mainClass :: model.mainTagAttrs) model.mainTagContent
        , section
            [ class "main-player"
            , attribute "aria-labelledby" model.playingMusicName
            ]
            model.playerTagContent
        ]
    ]


viewHeader : Model msg -> Html msg
viewHeader model =
    let
        currentPage route =
            if model.route == route then
                True

            else
                False
    in
    header [ class "main-header" ]
        [ Svg.spotify Svg.Robust
        , nav
            [ class "main-header__nav" ]
            [ viewLink
                { defaultLink
                    | routeName = caseNamePage Route.Home_
                    , routeStatic = Route.Home_
                    , routeReceived = model.route
                    , svgLink = Just <| Svg.home <| currentPage Route.Home_
                }
            , viewLink
                { defaultLink
                    | routeName = caseNamePage Route.Search
                    , routeStatic = Route.Search
                    , routeReceived = model.route
                    , svgLink = Just <| Svg.search <| currentPage Route.Search
                }
            , viewLink
                { defaultLink
                    | routeName = caseNamePage Route.YourLibrary
                    , routeStatic = Route.YourLibrary
                    , routeReceived = model.route
                    , svgLink = Just <| Svg.books <| currentPage Route.YourLibrary
                }
            ]

        -- For now this is a static page
        , List.map
            (\( svg, name ) ->
                a [ class "main-header__links", href "#" ] [ svg, text name ]
            )
            [ ( Svg.plus Svg.SmallPlus, "Create Playlist" ), ( Svg.heart, "Liked Songs" ), ( Svg.signal, "Your Episodes" ) ]
            |> nav [ class "main-header__nav" ]
        ]
