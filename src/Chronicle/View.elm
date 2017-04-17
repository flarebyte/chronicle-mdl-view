module Chronicle.View
    exposing
        (
        unique
        )

{-| Convenience functions for filtering list of ntriples

# Basics
@docs  unique

-}

import List exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href, class, style, src)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout
import Material.Color as Color
import Material.Menu as Menu
import Material.Options as Options exposing (css, cs, when)



{-| Remove duplicate values, keeping the first instance of each element which appears more than once.

    unique [0,1,1,0,1] == [0,1]
-}
unique : List comparable -> List comparable
unique list =
    list

-- MODEL


type alias Model =
    { count : Int
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE


type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW


type alias Mdl =
    Material.Model

viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        []
        [ Layout.title [] [ text "elm-mdl Dashboard Example" ]
        , Layout.spacer
        , Layout.navigation []
            []
        ]

navLink = "http://localhost:8000/nav"


drawerHeader : Model -> Html Msg
drawerHeader model =
    Layout.navigation []
    [
    Button.render Mdl
        [ 0 ]
        model.mdl
        [ Options.onClick Increase
        , css "margin" "0 24px"
        ]
        [ text "Increase" ]
    , Button.render Mdl
        [ 1 ]
        model.mdl
        [ Options.onClick Reset ]
        [ text "Reset" ]
    ]



view : Model -> Html Msg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ Layout.render Mdl model.mdl
        [ Layout.fixedHeader ]
        { header = [ viewHeader model ]
        , drawer = [ drawerHeader model ]
        , tabs = ([], [])
        , main = [
          text ("Current count: " ++ toString model.count)
        ]
        }
        ]
        |> Material.Scheme.top



-- Load Google Mdl CSS. You'll likely want to do that not in code as we
-- do here, but rather in your master .html file. See the documentation
-- for the `Material` module for details.


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
