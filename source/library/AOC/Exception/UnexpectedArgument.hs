module AOC.Exception.UnexpectedArgument where

import qualified Control.Monad.Catch as Exception

newtype UnexpectedArgument
  = RawUnexpectedArgument String
  deriving (Eq, Show)

instance Exception.Exception UnexpectedArgument

new :: String -> UnexpectedArgument
new = RawUnexpectedArgument
