module AOC.Exception.InvalidOption where

import qualified Control.Monad.Catch as Exception

newtype InvalidOption
  = RawInvalidOption String
  deriving (Eq, Show)

instance Exception.Exception InvalidOption

new :: String -> InvalidOption
new = RawInvalidOption
