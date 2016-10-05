port module Main exposing (main)

import Html.App as App
import Model exposing (Model, Pocasi)
import Update exposing (Msg(Add), updateWithStorage)
import View exposing (view)
import Subscriptions exposing (subscriptions)


main =
    App.programWithFlags
        { init = init
        , view = view
        , update = updateWithStorage
        , subscriptions = subscriptions
        }


init : Maybe Model -> ( Model, Cmd msg )
init savedModel =
    Maybe.withDefault [] savedModel ! []
