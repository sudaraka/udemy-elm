module CoinFlip exposing (..)

import Html exposing (Html, div, text, program, button)
import Random
import Html.Events exposing (onClick)


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { side : String }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model "Heads", Cmd.none )



-- MESSAGES


type Msg
    = StartFlip
    | GenerateFlip Bool



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartFlip ->
            ( model, Random.generate GenerateFlip Random.bool )

        GenerateFlip bool ->
            ( { model | side = generateSide bool }, Cmd.none )


generateSide : Bool -> String
generateSide side =
    if side then
        "Heads"
    else
        "Tails"



-- SUBSCRIPTION


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text ("The results is:" ++ model.side)
        , div []
            [ button [ onClick StartFlip ] [ text "Flip!" ]
            ]
        ]
