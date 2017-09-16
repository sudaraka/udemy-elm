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
        , div [ checkTextSize model.text ] [ text model.text ]
        ]


checkTextSize : String -> Attribute msg
checkTextSize str =
    if 8 < String.length str then
        smallText
    else
        bigText


smallText : Attribute msg
smallText =
    style
        [ ( "fontSize", "3em" )
        , ( "color", "red" )
        ]


bigText : Attribute msg
bigText =
    style
        [ ( "fontSize", "5em" )
        , ( "color", "sandybrown" )
        ]
