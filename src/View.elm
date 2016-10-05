module View exposing (view)

import Html exposing (Html, Attribute, div, table, thead, tbody, tr, th, td, text)
import Html.Attributes exposing (class)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy)
import String exposing (join)
import Svg exposing (svg, polyline)
import Svg.Attributes exposing (width, height, fill, stroke, points)
import Model exposing (Model, Pocasi)


view : Model -> Html msg
view model =
    div []
        [ svg
            [ width "600", height "100" ]
            [ polyline [ fill "none", stroke "black", points (join " " (List.indexedMap (\a b -> ((toString (600 - (a * 10))) ++ "," ++ (toString (100 - b.vlhkost)))) model)) ] [] ]
        , table []
            [ thead []
                [ tr []
                    [ th [] [ text "Den Cas" ]
                    , th [] [ text "Teplota" ]
                    , th [] [ text "Tlak" ]
                    , th [] [ text "Vlhkost" ]
                    , th [] [ text "RosBod" ]
                    ]
                ]
            , (lazy viewModel model)
            ]
        ]


viewModel : Model -> Html msg
viewModel model =
    if not (List.isEmpty model) then
        Keyed.node "tbody" [] (List.map viewKeyedPocasi model)
    else
        text ""


viewKeyedPocasi : Pocasi -> ( String, Html msg )
viewKeyedPocasi pocasi =
    ( pocasi.den ++ pocasi.cas, lazy viewPocasi pocasi )


viewPocasi : Pocasi -> Html msg
viewPocasi pocasi =
    tr []
        [ td []
            [ text pocasi.den
            , text " "
            , text pocasi.cas
            ]
        , td [ class "number" ]
            [ text (toString pocasi.teplota)
            , text " °C"
            ]
        , td [ class "number" ]
            [ text (toString pocasi.tlak)
            , text " hPa"
            ]
        , td [ class "number" ]
            [ text (toString pocasi.vlhkost)
            , text " %"
            ]
        , td [ class "number" ]
            [ text (toString pocasi.rosbod)
            , text " °C"
            ]
        ]
