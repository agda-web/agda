{-# OPTIONS_GHC -Wunused-imports #-}

{-# LANGUAGE CPP             #-}
{-# LANGUAGE TemplateHaskell #-}

#if __GLASGOW_HASKELL__ >= 900
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
#endif

module Agda.VersionCommit where

import Agda.Version

versionWithCommitInfo :: String
versionWithCommitInfo = version ++ maybe "" ("-" ++) commitInfo

-- | Information about current git commit, generated at compile time
commitInfo :: Maybe String
commitInfo
  | hash == "UNKNOWN" = Nothing
  | otherwise         = Just $ abbrev hash ++ "-dirty"
  where
    hash = "9cf3dcf0290e2286404b768ff54420e3463b3382"

    -- Check if any tracked files have uncommitted changes
    --dirty | $(gitDirtyTracked) = "-dirty"
    --      | otherwise          = ""

    -- Abbreviate a commit hash while keeping it unambiguous
    abbrev = take 7
