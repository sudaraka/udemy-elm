module CoinFlip exposing (..)

import Html exposing (Html, div, text, program, button, img, Attribute, br)
import Html.Attributes exposing (src, style)
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
    { side : String
    , number : Int
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model "Heads" 0, Cmd.none )



-- MESSAGES


type Msg
    = StartFlip
    | GenerateFlip Bool
    | GetNumber
    | GenerateNumber Int



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartFlip ->
            ( model, Random.generate GenerateFlip Random.bool )

        GenerateFlip bool ->
            ( { model | side = generateSide bool }, Cmd.none )

        GetNumber ->
            ( model, Random.generate GenerateNumber (Random.int 1 100) )

        GenerateNumber num ->
            ( { model | number = num }, Cmd.none )


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
    div
        [ style
            [ ( "fontSize", "4em" )
            , ( "textAlign", "center" )
            ]
        ]
        [ img
            [ getImage model
            , style
                [ ( "height", "100px" )
                , ( "width", "150px" )
                ]
            ]
            []
        , br [] []
        , text ("The results is:" ++ model.side)
        , div []
            [ button [ onClick StartFlip ] [ text "Flip!" ]
            ]
        , div []
            [ text ("Random number is:" ++ toString model.number)
            , br [] []
            , button [ onClick GetNumber ] [ text "Generate Number" ]
            ]
        ]


getImage : Model -> Attribute msg
getImage model =
    let
        imgUrl =
            if "Heads" == model.side then
                "../images/heads.jpeg"
            else
                "../images/tails.jpeg"
    in
        src imgUrl
