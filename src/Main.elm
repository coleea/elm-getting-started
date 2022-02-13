module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http
import Json.Encode as Encode

---- MODEL ----
type alias Model = List String
init : ( Model, Cmd Msg )
init = ( ["엉덩국", "김삿갓"], Cmd.none )

---- UPDATE ----
type Msg 
    = SendHttpRequest
    | DataReceived (Result Http.Error String)

url : String
url =
    "https://enabled-haddock-43.hasura.app/v1/graphql"

getNicknames : Cmd Msg
getNicknames =
    let
        headers = 
            [Http.header "content-type" "application/json" 
            , Http.header "x-hasura-admin-secret" "Yu5oC3d8brqEBcWVs641WMrU26PaYSoWBTr5rriloATN089IbI4RhAgv4Bvsf9TZ"
            ]
                    
        body = Http.jsonBody (Encode.object
                [ ( "query", Encode.string """query {
                            LIVE_CODING_MOUM {
                                username
                                date
                                duration
                                stack
                                thumbnail
                                url
                                title
                            }
                        }                   
                """ )
                ])
      
    in
    Http.request
        { method = "POST"
        , url = url
        , headers = headers
        , expect = Http.expectString DataReceived
        , body = body
        , timeout = Nothing
        , tracker = Nothing
        }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getNicknames )
        DataReceived (Ok responseStr) ->
            let
                nicknames =
                    String.split "," responseStr
            in
            ( nicknames, Cmd.none )

        DataReceived (Err _) ->
            ( model, Cmd.none )

---- VIEW ----
view : Model -> Html Msg
view model =
    div [class "flex flex-col justify-center items-center h-full"]
        [ button [ onClick SendHttpRequest ]
            [ text "Get data from server" ]
        , h2 [class "text-5xl font-extrabold"] [ text "Old School Main Characters" ]
        , ul [class "text-3xl"] (List.map viewNickname model)
        ]

viewNickname : String -> Html Msg
viewNickname nickname = li [] [ text nickname ]

---- PROGRAM ----
main : Program () Model Msg
main =
    Browser.element
        { view = view
        , update = update
        , init = \_ -> init
        , subscriptions = always Sub.none
        }