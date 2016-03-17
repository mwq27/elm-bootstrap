module HomePage where

import StartApp
import Html exposing (div, text, span, button)
import Effects exposing (Effects, Never)
import Html.Attributes exposing(..)
import Html.Events exposing(onClick, on, targetValue)
import Modal exposing (..)
import Task

-- Ports
port modalPort : Signal Int

port initModalPort : Signal String

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks

-- Model
type Action =
  NoOp
  | OpenModal
  | CloseModal

-- Update
update: Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    OpenModal ->
      ( bsOpenModal, Effects.none)
    CloseModal ->
      ( bsCloseModal, Effects.none)
    NoOp ->
      (model, Effects.none)


escKeyPressed keyCode =
  case keyCode of
    27 -> CloseModal
    _ -> NoOp

initModal target =
  OpenModal

-- View


view: Signal.Address Action -> Model -> Html.Html
view address model =
  div
    [id "container"]
    [
      div
        [ classList [
            ("modal-backdrop", True)
            , ("fade", True)
            , ("in", model.isShown)
            , ("hide", not model.isShown)
          ]
        ]
        []
      , button
          [type' "button", attribute "data-toggle" "modal", attribute "data-target" "#myModal"]
          [text "Show Modal"]
      , div
        [ classList [
              ("modal", True)
              , ("fade", True)
              , ("in", model.isShown)
              , ("show", model.isShown)
          ],
          id "myModal"
        ]
        [
          div
            [ class "modal-dialog" ]
            [
              div
                [ class "modal-content" ]
                [
                  div
                    [ class "modal-header" ]
                    [ text "This is a modal header"
                      , button
                          [ class "close"
                            , attribute "data-dismiss" "modal"
                            , type' "button"
                            , onClick address CloseModal
                          ]
                          [ span
                              []
                              [text "x"]
                          ]
                    ]
                  , div
                      [ class "modal-body" ]
                      [ text "This is the body" ]
                  , div
                      [ class "modal-footer" ]
                      [
                        button
                          [ type' "button" ]
                          [ text "Close"]
                        , button
                            [ type' "button"
                              , attribute "data-dismiss" "modal"
                              , onClick address CloseModal
                            ]
                            [ text "Save Changes" ]
                      ]
                ]
            ]
        ]
    ]

app: StartApp.App Model
app =
  StartApp.start
    {
      init = (initialModel, Effects.none )
    , update = update
    , view = view
    , inputs = [
        Signal.map escKeyPressed modalPort
      , Signal.map initModal initModalPort
      ]
    }

main : Signal Html.Html
main =
  app.html
