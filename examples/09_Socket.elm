module SocketChat exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import WebSocket


main =
    Html.program
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }



-- MODEL


type alias Model =
    { input : String
    , messages : List String
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )


socketUrl : String
socketUrl =
    "ws://echo.websocket.org"



-- UPDATE


type Msg
    = Input String
    | SendToSocket
    | NewMessageReceived String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input str ->
            ( { model | input = str }, Cmd.none )

        SendToSocket ->
            ( { model | input = "" }, WebSocket.send socketUrl model.input )

        NewMessageReceived str ->
            ( { model | messages = str :: model.messages }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen socketUrl NewMessageReceived



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ ul []
            (List.reverse
                (List.map
                    (\msg -> li [] [ text msg ])
                    model.messages
                )
            )
        , input [ onInput Input, value model.input ] []
        , button [ onClick SendToSocket ] [ text "Send" ]
        ]
