module AOC.D1.P1 where

import qualified Data.Char as Char
import Data.Function ((&))
import qualified Data.Maybe as Maybe
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import qualified Text.Read as Read

run :: IO ()
run = Text.interact $ \ input -> input
  & Text.lines
  & fmap (Text.filter Char.isDigit)
  & Maybe.mapMaybe (\ x -> do
    (h, _) <- Text.uncons x
    (_, t) <- Text.unsnoc x
    Read.readMaybe [h, t])
  & sum
  & (\ x -> x :: Int)
  & show
  & (<> "\n")
  & Text.pack
