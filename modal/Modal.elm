module Modal (..) where

import StartApp
import Effects exposing (Effects, Never)
import Html exposing (div, text, span, button)
import Html.Attributes exposing(..)
import Html.Events exposing(onClick, on, targetValue)
import Keyboard


-- Events
-- onShowBsModal =
--   on "showBsModal" targetValue (\v -> Signal.message address (v))

-- Model

type alias Model =
  {
    isShown: Bool
    , options: Config
  }

type alias Config =
  {
    keyboard: Bool
    , show: Bool
    , backdrop: Bool
  }

initialModel: Model
initialModel =
  {
    isShown = False
    , options =
      {
        keyboard = True
        , show = False
        , backdrop = True
      }
  }

-- Update
bsBackdrop =
  div
    [ classList [
        ("modal-backdrop", True)
        , ("fade", True)
        , ("in", model.isShown)
        , ("hide", not model.isShown)
      ]
    ]
    []

bsOpenModal =
  { initialModel | isShown = True }

bsCloseModal =
  { initialModel | isShown = False}
