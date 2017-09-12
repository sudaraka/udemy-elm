module ArchitectedHello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- This is what our model should look like


type alias Model =
    { text : String
    , size : Int
    }


model : Model
model =
    { text = "Hello World"
    , size = 1
    }



-- Only need one kind of message


type Msg
    = Text
    | Size



-- Update function only have to worry about once possible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text ->
            { model | text = model.text ++ "!" }

        Size ->
            { model | size = model.size + 1 }



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ appStyle model.size ] [ text model.text ]
        , button [ onClick Text ] [ text "Add exclamation mark" ]
        , button [ onClick Size ] [ text "+" ]
        ]


appStyle : Int -> Attribute msg
appStyle size =
    style
        [ ( "fontSize", toString size ++ "em" )
        , ( "color", "teal" )
        ]
