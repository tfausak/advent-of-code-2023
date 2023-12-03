module AOC.D1.P2 where

import qualified Control.Applicative as Applicative
import qualified Data.Char as Char
import Data.Function ((&))
import qualified Data.Maybe as Maybe
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import qualified Text.Read as Read

run :: IO ()
run = Text.interact $ \ input -> input
  & replace
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

replace :: Text.Text -> Text.Text
replace x =
  let replacements =
        [ ("one", "1")
        , ("two", "2")
        , ("three", "3")
        , ("four", "4")
        , ("five", "5")
        , ("six", "6")
        , ("seven", "7")
        , ("eight", "8")
        , ("nine", "9")
        ]
      f (old, new) = case Text.stripPrefix (Text.pack old) x of
        Nothing -> Nothing
        Just y -> Just (Text.pack new, y)
  in case Applicative.asum $ fmap f replacements of
    Nothing -> case Text.uncons x of
      Nothing -> x
      Just (h, t) -> Text.cons h $ replace t
    Just (new, rest) -> new <> replace rest
