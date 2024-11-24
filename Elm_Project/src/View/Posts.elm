module View.Posts exposing (..)
import Html exposing (Html, div, text)
import Html.Attributes exposing (href)
import Html.Events
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToString)
import Time
import Util.Time



postTable : PostsConfig -> Time.Posix -> List Post -> Html Msg
postTable config currentTime posts =
    let
        filteredPosts =
            filterPosts config posts
    in
    Html.table []
        [ Html.thead []
            [ Html.tr []
                [ Html.th [ Html.Attributes.class "post-score" ] [ text "Score" ]
                , Html.th [ Html.Attributes.class "post-title" ] [ text "Title" ]
                , Html.th [ Html.Attributes.class "post-type" ] [ text "Type" ]
                , Html.th [ Html.Attributes.class "post-time" ] [ text "Posted" ]
                , Html.th [ Html.Attributes.class "post-url" ] [ text "Link" ]
                ]
            ]
        , Html.tbody [] 
            (List.map 
                (\post ->
                    let
                        duration = 
                            Util.Time.durationBetween post.time currentTime
                                |> Maybe.map Util.Time.formatDuration
                                |> Maybe.withDefault ""
                                
                        timeStr =
                            Util.Time.formatTime Time.utc post.time ++ 
                            (if duration /= "" then " (" ++ duration ++ ")" else "")
                    in
                    Html.tr []
                        [ Html.td [ Html.Attributes.class "post-score" ] [ text (String.fromInt post.score) ]
                        , Html.td [ Html.Attributes.class "post-title" ] [ text post.title ]
                        , Html.td [ Html.Attributes.class "post-type" ] [ text post.type_ ]
                        , Html.td [ Html.Attributes.class "post-time" ] [ text timeStr ]
                        , Html.td [ Html.Attributes.class "post-url" ] 
                            [ case post.url of
                                Just url -> Html.a [ href url ] [ text url ]
                                Nothing -> text ""
                            ]
                        ]
                )
                filteredPosts
            )
        ]




postsConfigView : PostsConfig -> Html Msg
postsConfigView config =
    div []
        [ Html.select 
            [ Html.Attributes.id "select-posts-per-page"
            , Html.Events.onInput (\str -> 
                case String.toInt str of
                    Just n -> ConfigChanged (ChangePostsToShow n)
                    Nothing -> ConfigChanged (ChangePostsToShow config.postsToShow)
              )
            ]
            [ Html.option [ Html.Attributes.selected (config.postsToShow == 10) ] [ text "10" ]
            , Html.option [ Html.Attributes.selected (config.postsToShow == 25) ] [ text "25" ]
            , Html.option [ Html.Attributes.selected (config.postsToShow == 50) ] [ text "50" ]
            ]
        , Html.select
            [ Html.Attributes.id "select-sort-by"
            , Html.Events.onInput (\str ->
                case sortFromString str of
                    Just sort -> ConfigChanged (ChangeSortBy sort)
                    Nothing -> ConfigChanged (ChangeSortBy config.sortBy)
              )
            ]
            (List.map (\sort -> 
                Html.option 
                    [ Html.Attributes.selected (sort == config.sortBy) ] 
                    [ text (sortToString sort) ]
            ) sortOptions)
        , Html.label []
            [ Html.input 
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "checkbox-show-job-posts"
                , Html.Attributes.checked config.showJobs
                , Html.Events.onCheck (\checked -> ConfigChanged (ChangeShowJobs checked))
                ] 
                []
            , text "Show job posts"
            ]
        , Html.label []
            [ Html.input 
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "checkbox-show-text-only-posts"
                , Html.Attributes.checked config.showTextOnly
                , Html.Events.onCheck (\checked -> ConfigChanged (ChangeShowTextOnly checked))
                ] 
                []
            , text "Show text-only posts"
            ]
        ]