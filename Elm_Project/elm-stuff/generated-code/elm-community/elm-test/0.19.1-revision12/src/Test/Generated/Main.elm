module Test.Generated.Main exposing (main)

import ExampleTests.CursorTests
import ExampleTests.ModelPostIdsTests
import ExampleTests.ModelPostsConfigTests
import ExampleTests.UtilTimeTests
import MainTests
import PostsConfigTests
import PostsViewTests
import PostTests
import SimulatedEffect
import TestData
import TestUtils

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = JsonReport
        , seed = 376158560164992
        , processes = 8
        , globs =
            []
        , paths =
            [ "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\ExampleTests\\CursorTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\ExampleTests\\ModelPostIdsTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\ExampleTests\\ModelPostsConfigTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\ExampleTests\\UtilTimeTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\MainTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\PostsConfigTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\PostsViewTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\PostTests.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\SimulatedEffect.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\TestData.elm"
            , "C:\\Users\\pante\\Desktop\\An3_sem1\\PF\\Proiect_Elm\\tests\\TestUtils.elm"
            ]
        }
        [ ( "ExampleTests.CursorTests"
          , [ Test.Runner.Node.check ExampleTests.CursorTests.suite
            ]
          )
        , ( "ExampleTests.ModelPostIdsTests"
          , [ Test.Runner.Node.check ExampleTests.ModelPostIdsTests.suite
            ]
          )
        , ( "ExampleTests.ModelPostsConfigTests"
          , [ Test.Runner.Node.check ExampleTests.ModelPostsConfigTests.suite
            ]
          )
        , ( "ExampleTests.UtilTimeTests"
          , [ Test.Runner.Node.check ExampleTests.UtilTimeTests.suite
            ]
          )
        , ( "MainTests"
          , [ Test.Runner.Node.check MainTests.suite
            ]
          )
        , ( "PostsConfigTests"
          , [ Test.Runner.Node.check PostsConfigTests.suite
            ]
          )
        , ( "PostsViewTests"
          , [ Test.Runner.Node.check PostsViewTests.currentTime
            , Test.Runner.Node.check PostsViewTests.selectShowJobPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectElementContainingShowJobPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectShowTextPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectElementContainingShowTextPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.suite
            ]
          )
        , ( "PostTests"
          , [ Test.Runner.Node.check PostTests.requiredFields
            , Test.Runner.Node.check PostTests.fields
            , Test.Runner.Node.check PostTests.fieldNames
            , Test.Runner.Node.check PostTests.completePost
            , Test.Runner.Node.check PostTests.suite
            ]
          )
        , ( "SimulatedEffect"
          , [ Test.Runner.Node.check SimulatedEffect.start
            , Test.Runner.Node.check SimulatedEffect.fromLoadedState
            ]
          )
        , ( "TestData"
          , [ Test.Runner.Node.check TestData.posts
            , Test.Runner.Node.check TestData.textPosts
            , Test.Runner.Node.check TestData.jobPosts
            ]
          )
        , ( "TestUtils"
          , []
          )
        ]