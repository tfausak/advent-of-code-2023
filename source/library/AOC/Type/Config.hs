module AOC.Type.Config where

import qualified AOC.Exception.ReadError as ReadError
import qualified AOC.Type.Day as Day
import qualified AOC.Type.Flag as Flag
import qualified AOC.Type.Part as Part
import qualified Control.Monad.Catch as Exception
import qualified Text.Read as Read

data Config = Config
  { day :: Maybe Day.Day
  , help :: Bool
  , part :: Maybe Part.Part
  , version :: Bool
  } deriving (Eq, Show)

initial :: Config
initial = Config
  { day = Nothing
  , help = False
  , part = Nothing
  , version = False
  }

applyFlag :: Exception.MonadThrow m => Config -> Flag.Flag -> m Config
applyFlag config flag = case flag of
  Flag.Day string -> do
    int <- either (Exception.throwM . ReadError.new) pure $ Read.readEither string
    d <- Day.fromInt int
    pure config { day = Just d }
  Flag.Help h -> pure config { help = h }
  Flag.Part string -> do
    int <- either (Exception.throwM . ReadError.new) pure $ Read.readEither string
    p <- Part.fromInt int
    pure config { part = Just p }
  Flag.Version v -> pure config { version = v }
