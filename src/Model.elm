module Model exposing (Model, Pocasi)


type alias Pocasi =
    { den : String
    , cas : String
    , teplota : Float
    , tlak : Int
    , vlhkost : Float
    , rosbod : Float
    }


type alias Model =
    List Pocasi
