module Utilities exposing (..)

-- Type annotations!


query : String
query =
    "tutorial"

stars : Int
stats = 1

searchResult : { name: String, stars, int }
searchResult = { name = "Tom", stars = 485 }

list : List String
list = [ "foo", "bar", "baz" ]

-- Int and Float are different

listOfFloats : List Float
listOfFloats = [2.2, 3.3, 4]
-- ERROR!


-- Type Aliases

model :
    { query : String
    , results :
        List
            { id : Int
            , name : String
            , stars : Int
            }
    }

-- This would get really ugly if we had to reuse
-- Type Aliases to the rescue!

type alias SearchResult =
    { id : Int
    , name : String
    , stars : Int
    }

type alias Model =
    { query : String
    , results : List SearchResult
    }

-- This is both reusable and cleaner


-- MSG's

type alias Msg =
    { operation : String
    , data : Int
    }

view : Model -> Html Msg
