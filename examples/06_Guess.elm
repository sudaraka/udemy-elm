module Guess exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias RevealedWord =
    { text : String
    , pos : Int
    }


type alias Result =
    { text : String
    , isCorrect : Bool
    }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : RevealedWord
    , result : Result
    , wordList : List String
    }


model : Model
model =
    Model "Saturday" "" (RevealedWord "S" 2) (Result "" False) initialWordList


initialWordList : List String
initialWordList =
    [ "Banana", "Kitten", "Orangutan", "Italic", "Paperclip", "Afternoon" ]


type Msg
    = Answer String
    | Reveal
    | Check
    | Another


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealedAndIncrement model }

        Check ->
            { model | result = checkResult model }

        Another ->
            let
                newWord =
                    getNewWord model
            in
                Model
                    newWord
                    ""
                    (RevealedWord (String.slice 0 1 newWord) 2)
                    (Result "" False)
                    (List.drop 1 model.wordList)


getNewWord : Model -> String
getNewWord { word, wordList } =
    wordList
        |> List.filter (\word -> word /= model.word)
        |> List.take 1
        |> String.concat


checkResult : Model -> Result
checkResult { word, guess, revealedWord, result } =
    if revealedWord.text == word then
        { result | text = "You didn't get it", isCorrect = False }
    else if String.toLower guess == String.toLower word then
        { result | text = "You got it!", isCorrect = True }
    else
        { result | text = "Nope", isCorrect = False }


revealedAndIncrement : Model -> RevealedWord
revealedAndIncrement { revealedWord, word, guess } =
    if String.toLower guess == String.toLower word then
        revealedWord
    else if String.length word == String.length revealedWord.text then
        revealedWord
    else
        { revealedWord
            | text = String.slice 0 revealedWord.pos word
            , pos = revealedWord.pos + 1
        }


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ h2 [] [ text ("I'm thinking of a " ++ toString (String.length model.word) ++ " letter word that starts with " ++ toString model.revealedWord.text) ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , div []
            [ button [ onClick Reveal ] [ text "Give me a hint" ]
            , button [ onClick Check ] [ text "Submit Answer" ]
            , button [ onClick Another ] [ text "Another Word" ]
            ]
        , generateResult model
        ]


mainStyle : Attribute msg
mainStyle =
    style
        [ ( "textAlign", "center" )
        , ( "fontSize", "2em" )
        , ( "fontFamily", "monospace" )
        ]


generateResult : Model -> Html Msg
generateResult { result } =
    if String.isEmpty result.text then
        div [] []
    else
        let
            color =
                if result.isCorrect then
                    "forestgreen"
                else
                    "tomato"
        in
            div
                [ style
                    [ ( "color", color )
                    , ( "fontSize", "5em" )
                    , ( "fontFamily", "impact" )
                    ]
                ]
                [ text result.text ]
