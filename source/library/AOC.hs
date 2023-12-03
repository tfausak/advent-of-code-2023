module AOC where

import qualified AOC.D1.P1
import qualified AOC.D1.P2
import qualified AOC.Exception.InvalidOption as InvalidOption
import qualified AOC.Exception.NotImplemented as NotImplemented
import qualified AOC.Exception.UnexpectedArgument as UnexpectedArgument
import qualified AOC.Exception.UnknownOption as UnknownOption
import qualified AOC.Type.Config as Config
import qualified AOC.Type.Day as Day
import qualified AOC.Type.Flag as Flag
import qualified AOC.Type.Part as Part
import qualified Control.Monad as Monad
import qualified Control.Monad.Catch as Exception
import qualified Data.Map as Map
import qualified Data.Version as Version
import qualified PackageInfo_aoc as This
import qualified System.Console.GetOpt as GetOpt
import qualified System.Environment as Environment
import qualified System.Exit as Exit

run :: IO ()
run = do
  arguments <- Environment.getArgs
  let (flgs, args, opts, errs) = GetOpt.getOpt' GetOpt.Permute Flag.options arguments
  Monad.forM_ errs $ Exception.throwM . InvalidOption.new
  Monad.forM_ args $ Exception.throwM . UnexpectedArgument.new
  Monad.forM_ opts $ Exception.throwM . UnknownOption.new
  config <- Monad.foldM Config.applyFlag Config.initial flgs

  Monad.when (Config.help config) $ do
    name <- Environment.getProgName
    putStr $ GetOpt.usageInfo name Flag.options
    Exit.exitSuccess

  Monad.when (Config.version config) $ do
    putStrLn $ Version.showVersion This.version
    Exit.exitSuccess

  day <- case Config.day config of
    Nothing -> Day.fromInt 1
    Just day -> pure day
  part <- case Config.part config of
    Nothing -> Part.fromInt 1
    Just part -> pure part
  solutions <- makeSolutionsMap
  solution <- case Map.lookup (day, part) solutions of
    Nothing -> Exception.throwM $ NotImplemented.new
    Just solution -> pure solution

  solution

makeSolutionsMap :: Exception.MonadThrow m => m (Map.Map (Day.Day, Part.Part) (IO ()))
makeSolutionsMap = Map.fromList <$> mapM
  (\ (d, p, v) -> do
    day <- Day.fromInt d
    part <- Part.fromInt p
    pure ((day, part), v))
  [ (1, 1, AOC.D1.P1.run)
  , (1, 2, AOC.D1.P2.run)
  ]
