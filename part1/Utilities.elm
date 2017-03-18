module Utilities exposing (..)


pluralize singular plural quantity =
    if quantity == 1 then
        toString quantity ++ " " ++ singular
    else
        toString quantity ++ " " ++ plural



-- Here's a contrived example of the same code, using Let blocks
-- This is also referred to as a `let-expression`


pluralize2 singular plural quantity =
    let
        quantityStr =
            toString quantity

        prefix =
            quantityStr ++ " "
    in
        if quantity == 1 then
            prefix ++ singular
        else
            prefix ++ plural


record =
    { name = "thing"
    , x = 1
    , y = 3
    }


tuple =
    ( "thing", 1, 3 )



-- destructuring


( name, x, y ) =
    tuple


list =
    [ 1, 2, 3 ]



-- In elm, lists must always be of the same type


listOfLists =
    [ [ "foo", "bar" ], [ "bar" ] ]
