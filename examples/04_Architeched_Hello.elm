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
    = AddBang
    | RemoveBang
    | SizeUp
    | SizeDown



-- Update function only have to worry about once possible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddBang ->
            { model | text = model.text ++ "!" }

        RemoveBang ->
            { model | text = bangChecker model.text }

        SizeUp ->
            { model | size = model.size + 1 }

        SizeDown ->
            { model | size = sizeChecker model.size }


bangChecker : String -> String
bangChecker str =
    if String.endsWith "!" str then
        String.dropRight 1 str
    else
        str


sizeChecker : Int -> Int
sizeChecker size =
    if 1 >= size then
        size
    else
        size - 1



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ appStyle model.size ] [ text model.text ]
        , button [ onClick AddBang ] [ text "Add !" ]
        , button [ onClick RemoveBang ] [ text "Remove !" ]
        , button [ onClick SizeDown ] [ text "-" ]
        , button [ onClick SizeUp ] [ text "+" ]
        ]


appStyle : Int -> Attribute msg
appStyle size =
    style
        [ ( "fontSize", toString size ++ "em" )
        , ( "color", "teal" )
        ]
