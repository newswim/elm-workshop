module Utilities exposing (..)
import Html exposting (..)

-- Let's look at how Currying is performed in Elm

pluralizeLeaf quantity =
    pluralize "leaf" "leaves" quantity

-- Functions in Elm are auto-curried by default, so we could instead write...

pluralizeLeaf2 =
    pluralize "leaf" "leaves"

-- `quantity` is not defined here, however we can still pass it to the function
-- that is returned from calling pluralizeLeaf2

curriedPluralize =
    pluralizeLeaf2 2

-- > "leaves"


{-

    Lists are immutable data structures, so performing a transformation will always return a new list.

    The common list functions include List.map and List.filter

    They are used similarly to the JavaScript functions by the same name

-}

isKeepable num = num >= 2

List.filter isKeepable [ 1, 2, 3 ]

-- > [ 2, 3 ]


-- Instead of defining a function expression, we could employ a lambda using `\`

List.filter (\num -> num >= 2) [ 1, 2, 3 ]

-- > [ 2, 3 ]


-- Now let's combine Currying with the List.map function

List.map (pluralize "leaf" "leaves") [ 1, 2, 3 ]

-- > [ "1 leaf", "2 leaves", "3 leaves" ]


--- Record Update Syntax

update msg model =
    if msg.operation == "SHOW_MORE" then
        { model | maxResults = model.maxResults + msg.data }
    else
        model
