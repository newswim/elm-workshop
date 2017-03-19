> ### Now Playing: Exercise 5 (02:05:18 - 02:09:29)

This example looks very similar to the last one, with a few additions:

- `Msg` has changed, and its values (constructors) are now functions which take additional arguments.
- Instead of having `type alias Msg`, it's now `type Msg` -- which is to say that it's now a **Union Type** instead of a Record.

Our goal with the first exercise is to start recording the `SetQuery` message. In a future exercise, we'll extract that value from the Model and use it in a query to GitHub's API, but to do that we need to first get it _into_ the model.

### Step 1 -- write it down

Typically the best practice for doing this is to use the `OnInput` function. You could also use `OnKeyDown`--but `OnInput` is a little bit better because it also captures things like copy and pasting with mouse events. `OnInput` basically captures **all** of the ways that you might manipulate a text field.

So, we'll use `OnInput` and define its behavior in a way to construct messages and send them to event handlers that we'll write here in a bit. The point being that we need to somehow get this user input data into the model.

> Something to know about `OnInput`. When you call it, you should only pass **ONE** argument, and that argument is supposed to be a _function_ which takes a string and returns some value (often a `message`).

It's worth noting that we already have a few functions which take `String` or `Int` arguments and return `Msg`'s...

- `DeleteById` is a function which takes an id and returns a message
- `SetQuery` is a function which takes a string and returns a message

(These may be helpful when working on the first _TODO:_)

It's essentially the same idea as before, except instead of passing a record, ie.

```elm
-- old way
view model =
    ...
        ...
            , input
                [ ... ]
                onInput (\str -> { operation = "SET_QUERY", data = "blah" })
```

We'll now pass our union type and decide behavior in our update function based upon the type of data it receives.

#### Note:

Where are `OnInput` takes a function that will generate the message, `OnClick` just takes the message itself. So when we call it, we'll just pass an individual message rather than a function.

Finally, we need to update our `update` function to account for the new  constructors present in `Msg`. So it's the basically the same as before, only now instead of using an If expression, we're going to use a Case expression to pull apart the different pieces of our Union Type and do the right thing.

> #### Now Playing: Audience Questions (02:09:29 - 02:13:03)

##### Question: Is the constructors in these unit types are function, where is the body of these functions? Where does it say what they do?

There is no "body" per se. These are "logic-less" functions, their entire purpose is to build up these "containers" of values. If we go to the REPL...

```elm
> type Msg = SetQuery String | DeleteById Int
> SetQuery
<function> : String -> Msg
> DeleteById
<function> : Int -> Msg
```

A `Msg` is sort of a _container_ that holds "two different flavors" of value. One is a string **wrapped** in a `SetQuery`, and the other is a an integer **wrapped** in a `DeleteById`.

The only way to get at these values is to write a Case expression:

```elm
...
    case msg of
        SetQuery query ->
            -- do setting of query stuff
        ...
```

One of the things that you can _**rely on**_ is that **anytime** you see a function with an UPPERCASE name, there is _NO_ logic in it. It's just for labeling/wrapping/returning these values.


> ### Now Playing: Exercise Solutions (02:13:03 - 02:21:48)
