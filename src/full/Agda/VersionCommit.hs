{-# OPTIONS_GHC -Wunused-imports #-}

{-# LANGUAGE CPP             #-}
{-# LANGUAGE TemplateHaskell #-}

#if __GLASGOW_HASKELL__ >= 900
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
#endif

module Agda.VersionCommit where

#if !defined(wasm32_HOST_ARCH)
import Development.GitRev
#endif

import Agda.Version

versionWithCommitInfo :: String
versionWithCommitInfo = version ++ maybe "" ("-" ++) commitInfo

-- | Information about current git commit, generated at compile time
commitInfo :: Maybe String
commitInfo
  | hash == "UNKNOWN" = Nothing
  | otherwise         = Just $ abbrev hash ++ dirty
  where
#if defined(wasm32_HOST_ARCH)
    hash = "UNKNOWN"
    dirty = ""
#else
    hash = $(gitHash)

    -- Check if any tracked files have uncommitted changes
    dirty | $(gitDirtyTracked) = "-dirty"
          | otherwise          = ""
#endif

    -- Abbreviate a commit hash while keeping it unambiguous
    abbrev = take 7
