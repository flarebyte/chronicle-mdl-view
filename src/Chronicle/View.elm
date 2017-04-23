module Chronicle.View
    exposing
        (
        unique,
        classicHeader,
        classicDrawer,
        classicFooter,
        classicList,
        classicEditor,
        ChronicleMsg(..),
        ChronicleModel
        )
{-| View for Chronicle

# Basics
@docs  unique, classicHeader, classicDrawer, classicFooter, classicList, classicEditor, ChronicleMsg, ChronicleModel

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

{-| ChronicleModel for Chronical View.

    unique [0,1,1,0,1] == [0,1]
-}
type alias ChronicleModel =
    { count : Int
    , triples: TriplesModel
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }

-- VIEW

u =
  {
  root = "http://root"
  , unknown = "http://unknown"
  , label = "http://label"
  , app = "application"
  , name = "name"
  , search = "search"
  }

type alias Pathway = List String

byPath : ChronicleModel -> Pathway -> String
byPath model paths =
  String.join "--" paths

firstPredicate : Pathway -> String
firstPredicate pathway =
  Maybe.withDefault u.unknown (
  List.head (
    Maybe.withDefault [u.unknown] (tail(pathway))
    )
  )

-- Fields

searchField : ChronicleModel -> Html ChronicleMsg
searchField model =
  Textfield.render Mdl [2] model.mdl
    [ Textfield.label (byPath model [u.root, u.label, u.search])
    , Textfield.floatingLabel
    , Textfield.text_
    ]
    []

editorField : ChronicleModel -> Pathway -> Html ChronicleMsg
editorField model pathway =
  Textfield.render Mdl [2] model.mdl
    [ Textfield.label (byPath model [u.root, u.label, firstPredicate(pathway)])
    , Textfield.floatingLabel
    , Textfield.text_
    ]
    []

{-| Header for Chronicle View.

    classicHeader [0,1,1,0,1] == [0,1]
-}
classicHeader : ChronicleModel -> Html ChronicleMsg
classicHeader model =
    Layout.row
        []
        [ Layout.title [] [ text (byPath model [u.label, u.app]) ]
        , Layout.spacer
        , searchField model
        , Layout.spacer
        , Layout.navigation []
            []
        ]

navLink = "http://localhost:8000/nav"


{-| Drawer for Chronicle View.

    classicDrawer [0,1,1,0,1] == [0,1]
-}
classicDrawer : ChronicleModel -> Html ChronicleMsg
classicDrawer model =
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

{-| Footer for Chronicle View.

    classicFooter [0,1,1,0,1] == [0,1]
-}
classicFooter : ChronicleModel -> Html ChronicleMsg
classicFooter model =
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
{-| List for Chronicle View.

    classicList [0,1,1,0,1] == [0,1]
-}

classicList : ChronicleModel -> Html ChronicleMsg
classicList model =
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

{-| Editor for Chronicle View.

    classicEditor [0,1,1,0,1] == [0,1]
-}
classicEditor : ChronicleModel -> Html ChronicleMsg
classicEditor model =
 div
  [ style [ ( "padding", "2rem" ) ] ]
  [
    editorField model ["base", "one"]
    , Layout.spacer
    , editorField model ["base", "two"]
    , editorField model ["base", "three"]
  ]

-- MESSAGE
{-| Message with UI

    unique [0,1,1,0,1] == [0,1]
-}
type ChronicleMsg
    = Increase
    | Reset
    | Mdl (Material.Msg ChronicleMsg)
