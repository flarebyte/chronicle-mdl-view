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
import Material.Footer as Footer
import Material.Textfield as Textfield
import Material.List as Lists


{-| Remove duplicate values, keeping the first instance of each element which appears more than once.

    unique [0,1,1,0,1] == [0,1]
-}
unique : List comparable -> List comparable
unique list =
    list

-- MODEL

type alias TriplesModel =
    { count : Int
    }

type alias Model =
    { count : Int
    , triples: TriplesModel
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { count = 0
    , triples = { count = 7 }
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

p =
  {
  root = "http://root"
  , unknown = "http://unknown"
  , label = "http://label"
  , app = "application"
  , name = "name"
  , search = "search"
  }

type alias Pathway = List String

byPath : Model -> Pathway -> String
byPath model paths =
  String.join "--" paths

firstPredicate : Pathway -> String
firstPredicate pathway =
  Maybe.withDefault p.unknown (
  List.head (
    Maybe.withDefault [p.unknown] (tail(pathway))
    )
  )

type alias Mdl =
    Material.Model

-- Fields

searchField : Model -> Html Msg
searchField model =
  Textfield.render Mdl [2] model.mdl
    [ Textfield.label (byPath model [p.root, p.label, p.search])
    , Textfield.floatingLabel
    , Textfield.text_
    ]
    []

editorField : Model -> Pathway -> Html Msg
editorField model pathway =
  Textfield.render Mdl [2] model.mdl
    [ Textfield.label (byPath model [p.root, p.label, firstPredicate(pathway)])
    , Textfield.floatingLabel
    , Textfield.text_
    ]
    []

viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        []
        [ Layout.title [] [ text (byPath model [p.label, p.app]) ]
        , Layout.spacer
        , searchField model
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

appFooter : Model -> Html Msg
appFooter model =
  Footer.mini []
    { left =
        Footer.left []
          [ Footer.logo [] [ Footer.html <| text "Mini Footer Example" ]
          , Footer.links []
              [ Footer.linkItem [ Footer.href "#footers" ] [ Footer.html <| text "Link 1"]
              , Footer.linkItem [ Footer.href "#footers" ] [ Footer.html <| text "Link 2"]
              , Footer.linkItem [ Footer.href "#footers" ] [ Footer.html <| text "Link 3"]
              ]
          ]

    , right =
        Footer.right []
          [ Footer.logo [] [ Footer.html <| text "Mini Footer Right Section" ]
          , Footer.socialButton [Options.css "margin-right" "6px"] []
          , Footer.socialButton [Options.css "margin-right" "6px"] []
          , Footer.socialButton [Options.css "margin-right" "0px"] []
          ]
    }

mainList : Model -> Html Msg
mainList model =
  Lists.ul []
 [ Lists.li [ Lists.withBody ]
     [ Lists.content []
         [ text "Robert Frost"
         , Lists.body [] [ text "I shall be telling this with a sigh / Somewhere ages and ages hence: / Two roads diverged in a wood, and I— / I took the one less traveled by, / And that has made all the difference." ]
         ]
     ]
 , Lists.li [ Lists.withBody ]
     [ Lists.content []
         [ text "Errett Bishop"
         , Lists.body [] [ text "And yet there is dissatisfaction in the mathematical community.  The pure mathematician is isolated from the world, which has little need of his brilliant creations. He suffers from an alienation which is seemingly inevitable: he has followed the gleam and it has led him out of this world."
           ]
         ]
     ]
 , Lists.li [ Lists.withBody ]
     [ Lists.content []
       [ text "Hunter Stockton Thompson"
       , Lists.body [] [ text "We were somewhere around Barstow on the edge of the desert when the drugs began to take hold. I remember saying something like »I feel a bit lightheaded; maybe you should drive...« " ]
       ]
     ]
 ]

mainEditor : Model -> Html Msg
mainEditor model =
 div
  [ style [ ( "padding", "2rem" ) ] ]
  [
    editorField model ["one", "two"]
  ]


view : Model -> Html Msg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ Layout.render Mdl model.mdl
        [ Layout.fixedHeader, Layout.fixedDrawer ]
        { header = [ viewHeader model ]
        , drawer = [ drawerHeader model ]
        , tabs = ([], [])
        , main = [
          text ("Current count: " ++ toString model.count)
          , Layout.spacer
          , mainList model
          , Layout.spacer
          , mainEditor model
          , appFooter model
        ]
        }
        ]
        |> Material.Scheme.top


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
