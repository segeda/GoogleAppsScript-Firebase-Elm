module Subscriptions exposing (subscriptions)

import Model exposing (Model, Pocasi)
import Update exposing (Msg(Add), updateWithStorage, add)


subscriptions : Model -> Sub Msg
subscriptions model =
    add Add
