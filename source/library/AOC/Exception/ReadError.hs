module AOC.Exception.ReadError where

import qualified Control.Monad.Catch as Exception

newtype ReadError
  = RawReadError String
  deriving (Eq, Show)

instance Exception.Exception ReadError

new :: String -> ReadError
new = RawReadError
