module AOC.Type.Day where

import qualified AOC.Exception.InvalidDay as InvalidDay
import qualified Control.Monad as Monad
import qualified Control.Monad.Catch as Exception

newtype Day
  = RawDay Int
  deriving (Eq, Ord, Show)

fromInt :: Exception.MonadThrow m => Int -> m Day
fromInt int = do
  Monad.when (int < 1) . Exception.throwM $ InvalidDay.new int
  Monad.when (int > 25) . Exception.throwM $ InvalidDay.new int
  pure $ RawDay int

toInt :: Day -> Int
toInt (RawDay int) = int
