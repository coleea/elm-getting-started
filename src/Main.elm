module Main exposing (..)
import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)

---- MODEL ----

type alias Model =
    {}

init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )

---- UPDATE ----

type Msg
    = NoOp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

---- VIEW ----

view : Model -> Html Msg
view model =
    div [class "flex items-center justify-center w-full h-full"]
        [ h1 [class "text-4xl p-5 font-bold bg-gray-200"] [ text "Elm에 오신것을 환영합니다" ]
        ]

---- PROGRAM ----

main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }