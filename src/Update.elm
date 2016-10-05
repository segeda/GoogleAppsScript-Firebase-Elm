port module Update exposing (Msg(Add), updateWithStorage, add)

import Model exposing (Model, Pocasi)


type Msg
    = Add Pocasi


port setStorage : Model -> Cmd msg


port add : (Pocasi -> msg) -> Sub msg


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, cmds ) =
            update msg model
    in
        ( newModel
        , Cmd.batch [ setStorage newModel, cmds ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add pocasi ->
            ( List.take 60 (pocasi :: model), Cmd.none )
