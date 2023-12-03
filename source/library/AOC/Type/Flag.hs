module AOC.Type.Flag where

import qualified System.Console.GetOpt as GetOpt

data Flag
  = Day String
  | Help Bool
  | Part String
  | Version Bool
  deriving (Eq, Show)

options :: [GetOpt.OptDescr Flag]
options =
  [ GetOpt.Option ['h', '?'] ["help"] (GetOpt.NoArg $ Help True) "Shows this help message, then exits."
  , GetOpt.Option [] ["no-help"] (GetOpt.NoArg $ Help False) ""
  , GetOpt.Option [] ["version"] (GetOpt.NoArg $ Version True) "Shows the version number, then exits."
  , GetOpt.Option [] ["no-version"] (GetOpt.NoArg $ Version False) ""
  , GetOpt.Option [] ["day"] (GetOpt.ReqArg Day "DAY") "Sets the day number. Defaults to '1'."
  , GetOpt.Option [] ["part"] (GetOpt.ReqArg Part "PART") "Sets the part number. Defaults to '1'."
  ]
