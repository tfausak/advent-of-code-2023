{-# LANGUAGE FlexibleContexts #-}

module AOC.D2.P1 where

import qualified Control.Applicative as Applicative
import qualified Control.Monad.Catch as Exception
import Data.Function ((&))
import qualified Text.Parsec as Parsec
import qualified Text.Read as Read

run :: IO ()
run = do
  input <- getContents
  games <- either Exception.throwM pure $ Parsec.parse gamesP "" input
  games
    & filter isPossible
    & fmap fst
    & sum
    & print

isPossible :: Game -> Bool
isPossible =
  let p :: (Int, Color) -> Bool
      p (n, c) = case c of
        Red -> n <= 12
        Green -> n <= 13
        Blue -> n <= 14
  in all (all p) . snd

type Games = [Game]

gamesP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Games
gamesP = Parsec.sepEndBy1 gameP Parsec.newline

type Game = (Int, Subsets)

gameP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Game
gameP = (,)
  <$> (Parsec.string "Game " *> intP)
  <*> (Parsec.string ": " *> subsetsP)

type Subsets = [Subset]

subsetsP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Subsets
subsetsP = Parsec.sepBy1 subsetP $ Parsec.string "; "

type Subset = [Chunk]

subsetP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Subset
subsetP = Parsec.sepBy1 chunkP $ Parsec.string ", "

type Chunk = (Int, Color)

chunkP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Chunk
chunkP = (,)
  <$> intP
  <*> (Parsec.char ' ' *> colorP)

intP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Int
intP = do
  ds <- Parsec.many1 Parsec.digit
  maybe (fail "impossible") pure $ Read.readMaybe ds

data Color
  = Red
  | Green
  | Blue
  deriving (Eq, Ord, Show)

colorP :: Parsec.Stream s m Char => Parsec.ParsecT s u m Color
colorP = Applicative.asum
  [ Red <$ Parsec.string "red"
  , Green <$ Parsec.string "green"
  , Blue <$ Parsec.string "blue"
  ]
