module AOC.Type.Part where

import qualified AOC.Exception.InvalidPart as InvalidPart
import qualified Control.Monad as Monad
import qualified Control.Monad.Catch as Exception

newtype Part
  = RawPart Int
  deriving (Eq, Ord, Show)

fromInt :: Exception.MonadThrow m => Int -> m Part
fromInt int = do
  Monad.when (int < 1) . Exception.throwM $ InvalidPart.new int
  Monad.when (int > 2) . Exception.throwM $ InvalidPart.new int
  pure $ RawPart int

toInt :: Part -> Int
toInt (RawPart int) = int
