module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple3)
import Chronicle.View exposing (..)


all : Test
all =
    describe "Chronicle.View"
        [ describe "unique" <|
            [ test "removes duplicates" <|
                \() ->
                    Expect.equal (Chronicle.View.unique [ 0, 1 ]) [ 0, 1 ]
            ]
        ]
