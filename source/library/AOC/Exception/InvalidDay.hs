module AOC.Exception.InvalidDay where

import qualified Control.Monad.Catch as Exception

newtype InvalidDay
  = RawInvalidDay Int
  deriving (Eq, Show)

instance Exception.Exception InvalidDay

new :: Int -> InvalidDay
new = RawInvalidDay
