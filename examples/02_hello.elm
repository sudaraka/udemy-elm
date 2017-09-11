module HelloTwo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)


main : Html msg
main =
    div [ class "elm-div" ]
        [ h1 [ class "banner" ] [ text "Welcome to my Elm Site !!!" ]
        , p [] [ text "I am liking Elm so far." ]
        , p [] [ text "Eger ti learn more about Elm." ]
        ]
