module Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), applyChanges, defaultConfig, filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Html.Attributes exposing (..)
import Model.Post exposing (Post)
import Time



type SortBy
    = Score
    | Title
    | Posted
    | None



sortOptions : List SortBy
sortOptions =
    [ Score, Title, Posted, None ]



sortToString : SortBy -> String
sortToString sort =
    case sort of
        Score ->
            "Score"

        Title ->
            "Title"

        Posted ->
            "Posted"

        None ->
            "None"



{-|

    sortFromString "Score" --> Just Score

    sortFromString "Invalid" --> Nothing

    sortFromString "Title" --> Just Title

-}
sortFromString : String -> Maybe SortBy
sortFromString str =
    case str of
        "Score" -> Just Score
        "Title" -> Just Title 
        "Posted" -> Just Posted
        "None" -> Just None
        _ -> Nothing



sortToCompareFn : SortBy -> (Post -> Post -> Order)
sortToCompareFn sort =
    case sort of
        Score ->
            \postA postB -> 
                compare postB.score postA.score 

        Title ->
            \postA postB ->
                compare ( String.toLower postA.title ) ( String.toLower postB.title) 

        Posted ->
            \postA postB ->
                compare (Time.posixToMillis postB.time) (Time.posixToMillis postA.time)

        None ->
            \_ _ -> EQ



type alias PostsConfig =
    { postsToFetch : Int
    , postsToShow : Int
    , sortBy : SortBy
    , showJobs : Bool
    , showTextOnly : Bool
    }



defaultConfig : PostsConfig
defaultConfig =
    PostsConfig 50 10 None False True



{-| A type that describes what option changed and how
-}
type Change
     = ChangePostsToShow Int
    | ChangeSortBy SortBy
    | ChangeShowJobs Bool  
    | ChangeShowTextOnly Bool



{-| Given a change and the current configuration, return a new configuration with the changes applied
-}
applyChanges : Change -> PostsConfig -> PostsConfig
applyChanges change config =
    case change of
        ChangePostsToShow n ->
            { config | postsToShow = n }
        ChangeSortBy sort ->
            { config | sortBy = sort }
        ChangeShowJobs show ->
            { config | showJobs = show }
        ChangeShowTextOnly show -> 
            { config | showTextOnly = show }




{-| Given the configuration and a list of posts, return the relevant subset of posts according to the configuration

Relevant local functions:

  - sortToCompareFn

Relevant library functions:

  - List.sortWith

-}
filterPosts : PostsConfig -> List Post -> List Post
filterPosts config posts =
    posts
        |> (if not config.showTextOnly then
                List.filter (.url >> (/=) Nothing)
            else
                identity
            )

        |> (if not config.showJobs then
                List.filter (.type_ >> (/=) "job")
            else
                identity
            
            )
            
        |> List.take config.postsToShow

        |> (case config.sortBy of
                None -> identity
                _ -> List.sortWith (sortToCompareFn config.sortBy)
            )