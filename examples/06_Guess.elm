module Guess exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : { text : String, pos : Int }
    , result : String
    }


model : Model
model =
    Model "Saturday" "" { text = "S", pos = 2 } ""


type Msg
    = Answer String
    | Reveal
    | Check


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealedAndIncrement model }

        Check ->
            { model | result = checkResult model }


checkResult : Model -> String
checkResult { word, guess, revealedWord } =
    if revealedWord.text == word then
        "You didn't get it"
    else if String.toLower guess == String.toLower word then
        "You got it!"
    else
        "Nope"


revealedAndIncrement : Model -> { pos : Int, text : String }
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
    if String.isEmpty result then
        div [] []
    else
        let
            color =
                if "Nope" == result then
                    "tomato"
                else
                    "forestgreen"
        in
            div
                [ style
                    [ ( "color", color )
                    , ( "fontSize", "5em" )
                    , ( "fontFamily", "impact" )
                    ]
                ]
                [ text result ]
