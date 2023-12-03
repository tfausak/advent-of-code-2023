module AOC.Exception.NotImplemented where

import qualified Control.Monad.Catch as Exception

data NotImplemented
  = RawNotImplemented
  deriving (Eq, Show)

instance Exception.Exception NotImplemented

new :: NotImplemented
new = RawNotImplemented
