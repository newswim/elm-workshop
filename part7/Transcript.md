## 7. Client-Server Communication
> now playing: Function Guarantees (3:23:58 - 03:31:52)

ELM BYLAWS ::::

Hear ye,

- Everything is immutable
- Everything shall have 1 (one) expression
- Same inputs, same outputs - _always_.

#### Example: a random number generator

A _guarantee_ of **all** functions in Elm is that, if you give them the _same_
arguments, they will `always` return the _same_ values. Without exceptions.

Okay so... what about things that return random value? o_O ??

So, in JavaScript we have `Math.random()`, when you call this function more than
once, it should always return a _different_ value.

In Elm, we have `Random.generate`

```elm
pickGreeting : List String -> String
```

This signature would not work, because it does not obey our above stated credo.

In stead of providing `pickGreeting` a string and it _always_ returning the same
string (as it would), we're gonna do this:

```elm
pickGreeting : List String -> Cmd Msg
```

#### What is a command (`Cmd`) and why is it taking a `Msg` rather than a `String`?

Remember back when we described the Elm Runtime:

[XX: insert image of Elm Runtime]

The Elm architecture has three components: Update, View and Model.

- `view` returns some Html
- `model` gives the `view` something to display
- `update` takes **messages** and the current model and uses it to compute a new model

How do Commands fit into all of this?

`Msg` is essentially _how_ the Elm Runtime talks to `update`.

We're going to UPDATE our `update`... (probably shouldn't pun here).

We're going to give it a `Cmd` to run, in addition to its primary task of
receiving messages and computing diffs of the model. `Cmd` is essentially some
logic that you want to run which doesn't follow the typical Elm Runtime. It's
a way of letting the system know that you wish to perform something special,
and requesting it be executed, then when it's finished we should get back a
`Msg` that contains the architecturally non-conforming value.

We're not changing any of the fundamentals of the runtime, just that `update`
now has a new functionality where it can talk to itself, in a way, and send back
information when commands are ran.

#### How do we get and use `Cmd`'s?

We're going to UPGRADE!

Previously, we've been using `Html.beginnerProgram` in the `main` function,

```elm
-- annotation for the update function of a Html.beginnerProgram
update : Msg -> Model -> Model

-- UPGRADE!!!
-- annotation for regular update function in Html.program
update : Msg -> Model -> ( Model, Cmd Msg )
```

Update will now return a Tuple of the model that we want, _plus_ a Command.

[XX: Insert image of `Cmd Msg` getting sent to the Elm Runtime]

Model will go and be used in the View, and the Command is going to go off
(asynchronously) to the Elm Runtime, and after any additional calls have been made,
call `update` again with the resulting `Msg`.

This would look like in code:

```elm
pickGreeting : List String -> Cmd Msg
-- used somewhere ...
( model, pickGreeting greetings )
-- returns the `Cmd Msg`
```

If you don't want to run a command, you just say `Cmd.none`--if you wanted to just
wanted to take the code so far and use `Html.program` instead of `Html.beginnerProgram`,
you would just go through the `update` and anywhere its returning `model`, instead
return `( model, Cmd.none )`, and it would work exactly the same.

Soon we'll start learning about various commands.

## Elm Functions do not perform side-effects
> now playing: Another Function Guarantee (03:31:52 03:38:58)

This can also be (and often is) restated, "Elm functions cannot _modify external state_".
