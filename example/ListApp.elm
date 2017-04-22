module ListApp
  exposing(..)
{-| ListApp

# Basics
@docs

-}

import Html exposing (..)
import Html.Attributes exposing (href, class, style, src)
import Material
import Material.Scheme
import Material.Layout as Layout
import Chronicle.View as View exposing
 ( classicHeader
 , classicDrawer
 , classicFooter
 , classicList
 , classicEditor
 , classicUpdate
 , ChronicleModel
 , ChronicleMsg(..)
 )

-- ACTION, UPDATE


model : ChronicleModel
model =
    { count = 0
    , triples = { count = 7 }
    , mdl = Material.model
    }


main : Program Never ChronicleModel View.ChronicleMsg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = classicUpdate
        }

view : ChronicleModel -> Html View.ChronicleMsg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ Layout.render Mdl model.mdl
        [ Layout.fixedHeader, Layout.fixedDrawer ]
        { header = [ classicHeader model ]
        , drawer = [ classicDrawer model ]
        , tabs = ([], [])
        , main = [
          text ("Current count: " ++ toString model.count)
          , Layout.spacer
          , classicList model
          , Layout.spacer
          , classicEditor model
          , classicFooter model
        ]
        }
        ]
        |> Material.Scheme.top
