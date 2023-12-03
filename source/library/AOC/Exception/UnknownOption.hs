module AOC.Exception.UnknownOption where

import qualified Control.Monad.Catch as Exception

newtype UnknownOption
  = RawUnknownOption String
  deriving (Eq, Show)

instance Exception.Exception UnknownOption

new :: String -> UnknownOption
new = RawUnknownOption
