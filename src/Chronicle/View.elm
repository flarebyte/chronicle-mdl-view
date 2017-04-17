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
import Html.Attributes exposing (href, class, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout



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

appHeader =
  header [ class "mdl-layout__header" ]
    [ div [ class "mdl-layout__header-row" ]
        [ span [ class "mdl-layout-title" ]
            [ text "Title" ]
        , div [ class "mdl-layout-spacer" ]
            []
        , nav [ class "mdl-navigation mdl-layout--large-screen-only" ]
            [ a [ class "mdl-navigation__link", href "" ]
                [ text "Link" ]
            , a [ class "mdl-navigation__link", href "" ]
                [ text "Link" ]
            , a [ class "mdl-navigation__link", href "" ]
                [ text "Link" ]
            , a [ class "mdl-navigation__link", href "" ]
                [ text "Link" ]
            ]
        ]
    ]

navLink = "http://localhost:8000/nav"

appDrawer =
  div [ class "mdl-layout__drawer" ]
    [ span [ class "mdl-layout-title" ]
        [ text "Title" ]
    , nav [ class "mdl-navigation" ]
        [ a [ class "mdl-navigation__link", href navLink ]
            [ text "Link" ]
        , a [ class "mdl-navigation__link", href navLink ]
            [ text "Link" ]
        , a [ class "mdl-navigation__link", href navLink ]
            [ text "Link" ]
        , a [ class "mdl-navigation__link", href navLink ]
            [ text "Link" ]
        ]
    ]
view : Model -> Html Msg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ text ("Current count: " ++ toString model.count)
          {- We construct the instances of the Button component that we need, one
             for the increase button, one for the reset button. First, the increase
             button. The first three arguments are:
               - A Msg constructor (`Mdl`), lifting Mdl messages to the Msg type.
               - An instance id (the `[0]`). Every component that uses the same model
                 collection (model.mdl in this file) must have a distinct instance id.
               - A reference to the elm-mdl model collection (`model.mdl`).
             Notice that we do not have to add fields for the increase and reset buttons
             separately to our model; and we did not have to add to our update messages
             to handle their internal events.
             Mdl components are configured with `Options`, similar to `Html.Attributes`.
             The `Options.onClick Increase` option instructs the button to send the `Increase`
             message when clicked. The `css ...` option adds CSS styling to the button.
             See `Material.Options` for details on options.
          -}
        , Layout.render Mdl model.mdl
        [ Layout.fixedHeader ]
        { header = [ appHeader ]
        , drawer = [appDrawer]
        , tabs = ([], [])
        , main = []
        }
        , Button.render Mdl
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
