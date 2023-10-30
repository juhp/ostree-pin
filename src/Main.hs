{-# LANGUAGE OverloadedStrings, TypeApplications #-}

module Main (main) where

import Control.Monad
import Data.Maybe (isNothing)
import GI.Gio.Objects.Cancellable
import GI.OSTree
import SimpleCmdArgs
import System.Posix.User (getEffectiveUserID)

import Paths_ostree_pin

-- FIXME un/pin all?
main :: IO ()
main =
  simpleCmdArgs (Just version) "Tool to update pinned ostree deployment"
  "See https://github.com/juhp/ostree-pin#readme" $
  program
  <$> switchWith 'n' "dryrun" "Dry run"
  <*> switchWith 'p' "rollback" "Pin previous (rollback) deployment"
  where
    -- FIXME allow deployment# ?
    program dryrun rollback = do
      euid <- getEffectiveUserID
      unless (euid == 0) $
        putStrLn "this program should be run with sudo"
      sysroot <- sysrootNewDefault
      -- see https://github.com/ostreedev/ostree/pull/2779
      sysrootInitializeWithMountNamespace sysroot (Nothing @Cancellable)
      sysrootLoad sysroot (Nothing @Cancellable)
      mdeploy <-
        if rollback
        then do
          (_,mprevious) <- sysrootQueryDeploymentsFor sysroot Nothing
          return mprevious
        else do
          mbooted <- sysrootGetBootedDeployment sysroot
          if isNothing mbooted
            then error "No booted deployment found!"
            else return mbooted
      case mdeploy of
        Nothing -> error "deployment not found"
        Just deploy -> do
          pinned <- deploymentIsPinned deploy
          if pinned
            then putStrLn "deployment already pinned"
            else do
            deploys <- sysrootGetDeployments sysroot
            pins <- filterM deploymentIsPinned deploys
            case pins of
              [] -> return ()
              [pin] ->
                unless dryrun $ do
                putStrLn "removing previous pin"
                sysrootDeploymentSetPinned sysroot pin False
              _ -> putStrLn "more than one deployment already pinned"
            unless dryrun $ do
              putStrLn $ "pinning " ++
                (if rollback then "previous" else "current") ++ " deployment"
              sysrootDeploymentSetPinned sysroot deploy True
