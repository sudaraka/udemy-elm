module Guess exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { word : String
    , guess : String
    , isCorrect : Bool
    }


model : Model
model =
    Model "Saturday" "" False


type Msg
    = Answer String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt, isCorrect = checkIfCorrect model txt }


checkIfCorrect : Model -> String -> Bool
checkIfCorrect model txt =
    if txt == model.word then
        True
    else
        False


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text ("I'm thinking of a word that starts with " ++ toString (String.slice 0 1 model.word)) ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , div [] [ generateResult model ]
        ]


generateResult : Model -> Html Msg
generateResult { isCorrect } =
    if isCorrect then
        text "You got it!"
    else
        text "Nope"
