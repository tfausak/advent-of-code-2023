module AOC.Exception.InvalidPart where

import qualified Control.Monad.Catch as Exception

newtype InvalidPart
  = RawInvalidPart Int
  deriving (Eq, Show)

instance Exception.Exception InvalidPart

new :: Int -> InvalidPart
new = RawInvalidPart
