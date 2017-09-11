module ArchitectedHello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- This is what our model should look like


type alias Model =
    { text : String }


model : Model
model =
    { text = "Hello World" }



-- Only need one kind of message


type Msg
    = Text



-- Update function only have to worry about once possible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text ->
            { model | text = model.text ++ "!" }



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ appStyle ] [ text model.text ]
        , button [ onClick Text ] [ text "Add exclamation mark" ]
        ]


appStyle : Attribute msg
appStyle =
    style
        [ ( "fontSize", "5em" )
        , ( "color", "teal" )
        ]
