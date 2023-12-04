module AOC.D2.P2 where

import qualified AOC.D2.P1 as P1
import qualified Control.Monad.Catch as Exception
import Data.Function ((&))
import qualified Data.Map as Map
import qualified Data.Tuple as Tuple
import qualified Text.Parsec as Parsec

run :: IO ()
run = do
  input <- getContents
  games <- either Exception.throwM pure $ Parsec.parse P1.gamesP "" input
  games
    & fmap toPower
    & sum
    & print

toPower :: P1.Game -> Int
toPower = product
  . Map.elems
  . Map.unionsWith max
  . fmap (Map.fromList . fmap Tuple.swap)
  . snd
