module AnotherHello exposing (..)

import Html exposing (..)


checkStatus : Int -> String
checkStatus status =
    if 200 == status then
        "You got it, dude!"
    else if 404 == status then
        "Page Not Found"
    else
        "Unknown Response"


statuses : List String
statuses =
    [ checkStatus 200
    , checkStatus 404
    , checkStatus 418
    ]


renderList : List String -> Html msg
renderList list =
    list
        |> List.map (\l -> li [] [ text l ])
        |> ul []


main : Html msg
main =
    div []
        [ h1 [] [ text "List of statuses:" ]
        , renderList statuses
        ]
