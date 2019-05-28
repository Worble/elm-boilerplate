port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (div, text)
import Url
import Url.Parser exposing (Parser, map, oneOf, parse, top)


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        route =
            toRoute <| Url.toString url

        model =
            Model key route (HomePage (HomeModel "Hello Worlds"))

        initial =
            routeHandler model route
    in
    initial



-- TYPES


type alias Model =
    { key : Nav.Key
    , route : Route
    , child : Child
    }


type alias HomeModel =
    { text : String }


type Child
    = HomePage HomeModel
    | NotFoundPage


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


type Route
    = Home
    | NotFound


type alias Flags =
    ()



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                result =
                    routeHandler model (toRoute (Url.toString url))
            in
            result



--ROUTING


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        ]


toRoute : String -> Route
toRoute string =
    case Url.fromString string of
        Nothing ->
            NotFound

        Just url ->
            Maybe.withDefault NotFound (parse routeParser url)


routeHandler : Model -> Route -> ( Model, Cmd Msg )
routeHandler model route =
    let
        commands =
            routeCommands route

        newModel =
            routeModel model route
    in
    ( newModel, commands )


routeModel : Model -> Route -> Model
routeModel model route =
    case route of
        Home ->
            { model | child = HomePage (HomeModel "Hello Worlds") }

        NotFound ->
            { model | child = NotFoundPage }


routeCommands : Route -> Cmd Msg
routeCommands route =
    case route of
        Home ->
            Cmd.none

        NotFound ->
            Cmd.none



--VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Elm"
    , body =
        [ case model.child of
            HomePage homeModel ->
                div [] [ text homeModel.text ]

            NotFoundPage ->
                div [] [ text "404 Not Found" ]
        ]
    }
