module UserInput exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- This is what our model should look like


type alias Model =
    { text : String }


model : Model
model =
    { text = "" }



-- Only need one kind of message


type Msg
    = Text String



-- Update function only have to worry about once possible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text txt ->
            { model | text = txt }



-- View


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Type text here", onInput Text ] []
        , div [ adjustSize model ] [ text model.text ]
        ]


adjustSize : Model -> Attribute msg
adjustSize { text } =
    let
        ( size, color ) =
            if 8 < String.length text then
                ( "2em", "red" )
            else
                ( "5em", "sandybrown" )
    in
        style
            [ ( "fontSize", size )
            , ( "color", color )
            ]
