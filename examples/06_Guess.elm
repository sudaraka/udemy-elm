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
    , revealedWord : String
    , revealedPos : Int
    }


model : Model
model =
    Model "Saturday" "" False "S" 2


type Msg
    = Answer String
    | Reveal


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt, isCorrect = checkIfCorrect model txt }

        Reveal ->
            { model | revealedWord = revealLetter model, revealedPos = model.revealedPos + 1 }


revealLetter : Model -> String
revealLetter model =
    if model.isCorrect then
        model.revealedWord
    else if String.length model.word == String.length model.revealedWord then
        model.word
    else
        String.slice 0 model.revealedPos model.word


checkIfCorrect : Model -> String -> Bool
checkIfCorrect model txt =
    if txt == model.word then
        True
    else
        False


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text ("I'm thinking of a word that starts with " ++ toString model.revealedWord) ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , button [ onClick Reveal ] [ text "Give me a hint" ]
        , div [] [ generateResult model ]
        ]


generateResult : Model -> Html Msg
generateResult { isCorrect, word, revealedWord } =
    if revealedWord == word then
        text "You didn't get it"
    else if isCorrect then
        text "You got it!"
    else
        text "Nope"
