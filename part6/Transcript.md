## Module Naming Conventions
> now playing: Exercise 6 (02:57:15 - 03:04:35)

At the top of every Elm file there will be a few declarations. First, you'll
need to specify a name to the compiler so that it knows how you want that
module to be identified. To do this, we use the `module` syntax,

```elm
module Main exposing (..)
```

This means I have a module (within the root folder) which I want to refer to
in others places as "Main". Additionally, I want to _expose_ all of the functions
contained within this module.

### Importing Modules

For any installed module, or any local module, you can use the `import` keyword
to exposing its functions within the current context.

```elm
import Html exposing (..)
import Html.Attributes exposing (class, target, href, property, defaultValue)
import Html.Events exposing (..)
import SampleResponse                 -- this is a local module
```

Notice that the `.` (dot) operator indicates folder hierarchy. If you dig into
the "elm-stuff" folder, open `packages > elm-lang > html > 2.0.0 > src` you'll
see the `Attributes.elm` file that this import statement is pointing to.

For local imports of single constants, we can just use the `import` statement
followed by the name of the module.

## The GitHub API

GitHub has a guide available [here](https://developer.github.com/).
In this, they talk about (among other things), an example--a giant JSON blob.
From the example, there are only three fields that we really care about:
 - `id : Int`
 - `name : String`
 - `stars : Int`

 The reason being that they correspond to our search result.

If we look at the [sample search results](https://developer.github.com/v3/search/#example),
notice that what we call "name", they actually call "full_name". Other fields,
such as "id" already have a valid integer for its value so we don't need to do
anything to scrub that data. An example of this "scrubbing" is the mapping we'll
have to make for going from "full_name" to "name" within the model of our program.

Luckily there's no a type conversion that we'll have to make in this case, `id` is
an Integer, `name` ("full_name") is a String--however where they've name the field
"stargazers_count", we're going to refer to value simply as "stars"--another
manual mapping. By doing this, we'll get familiar with the process--Win!

### "Hardcoded" search results

If you don't want to enforce decoding at all, you can use the "hardcoded" decoder
within a pipeline to just safely bypass the step. This is what we're initially
given in the exercise:

```elm
searchResultDecoder =
    decode SearchResult
        |> hardcoded 0            -- id
        |> hardcoded ""           -- name
        |> hardcoded 0            -- stars
```

But this isn't what we want--what we want is to set-up a decoding pipeline.

- Change each of these fields to `required`
- Follow that by the name of the field
- Followed by the decoder which will decode that field

In our case the decoder will just be String or Int, depending on which field it is.

**Remember** that the order of the steps in the pipeline corresponds to the ordering
of the fields in the function, which corresponds to the ordering of the fields in the
Type Alias.

```elm
type alias SearchResult =
  { id : Int
  , name : String
  , stars : Int
  }
```

#### The other TODO . . .

In the `decodeResults` function, we're calling `decodeString` on the `responseDecoder`,
and this is just returning the list "items" from the JSON result.

This function is going to return one of these search results. Remember that when
you decode a string, it's not necessarily going to succeed--we need to handle
both possible cases, not just the "happy path".

When the return type is "Ok", we'll get a list of search results, and when there's
an error, we'll get "Err" with a corresponding String that describes what happened.

## But first, QUESTIONS
> now playing (03:04:35 - 03:11:03)

> Q: What's the deal with `decode identity`?

A: Identity is a function which is built into the language and just returns
whatever argument you call it with. Basically the only time that you can use
one of these pipelines with `identity` is if you have only one field that you're
decoding, and therefore only need to return one thing. We're using it in this
case just to keep with the pipeline style of decoders so as to not introduce
the alternative API (yet). Good question.

> Q: What are `list` and `searchResultDecoder` lowercase in that code sample?

A: `searchResultDecoder` is a customer decoder that _we've_ defined. The only
time that you ever get functions that are capitalized are in **two scenarios**.

1. It's in a Union Type
2. It's a type alias on a Record

```elm
-- An example Union Type

type Foo
    = Bar
    | Baz String


-- A type alias for a record

type alias Something =
    { foo : String, bar : Int }


-- when calling "Something", which is a function
-- the first argument corresponds to the first field, and so on

Something "blah" 42
```

`list` is a built-in function which comes with the JSON parsing library. What it
does is to take some kind of Decoder and object and returns a Decoder with a list
of those objects. Here's an example type signature:

```elm
list : Decoder SearchResult -> Decoder (List SearchResult)
```

> Q: What is the difference between lowercase `int` and `Int`?

A: Capital `Int` is _only_ used for type annotations. Lowercase `int` on the
other hand, is a function which we imported from `Json.Decode`.
