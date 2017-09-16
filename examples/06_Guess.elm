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
    , revealedWord : { text : String, pos : Int }
    }


model : Model
model =
    Model "Saturday" "" False { text = "S", pos = 2 }


type Msg
    = Answer String
    | Reveal


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt, isCorrect = checkIfCorrect model txt }

        Reveal ->
            { model | revealedWord = revealedAndIncrement model }


revealedAndIncrement : Model -> { pos : Int, text : String }
revealedAndIncrement { revealedWord, word, isCorrect } =
    if isCorrect then
        revealedWord
    else if String.length word == String.length revealedWord.text then
        revealedWord
    else
        { revealedWord
            | text = String.slice 0 revealedWord.pos word
            , pos = revealedWord.pos + 1
        }


checkIfCorrect : Model -> String -> Bool
checkIfCorrect model txt =
    if txt == model.word then
        True
    else
        False


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text ("I'm thinking of a word that starts with " ++ toString model.revealedWord.text) ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , button [ onClick Reveal ] [ text "Give me a hint" ]
        , div [] [ generateResult model ]
        ]


generateResult : Model -> Html Msg
generateResult { isCorrect, word, revealedWord } =
    let
        txt =
            if revealedWord.text == word then
                "You didn't get it"
            else if isCorrect then
                "You got it!"
            else
                "Nope"
    in
        text txt
