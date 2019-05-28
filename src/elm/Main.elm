port module Main exposing (main)

import Browser
import Html exposing (Html, div, text)


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Hello World", Cmd.none )



-- TYPES


type alias Model =
    { text : String
    }


type Msg
    = NoOp


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



--VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model.text
        ]
