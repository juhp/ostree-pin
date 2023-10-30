{-# LANGUAGE OverloadedStrings, TypeApplications #-}

module Main (main) where

import Control.Monad
import Data.Maybe (isNothing)
import GI.Gio.Objects.Cancellable
import GI.OSTree
import SimpleCmdArgs

-- FIXME un/pin all?
main :: IO ()
main =
  simpleCmdArgs Nothing "Tool to update pinned ostree deployment"
  "See https://github.com/juhp/ostree-pin#readme" $
  program
  <$> switchWith 'n' "dryrun" "Dry run"
  <*> switchWith 'p' "rollback" "Pin previous (rollback) deployment"
  where
    -- FIXME allow deployment# ?
    program dryrun rollback = do
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
                putStrLn "unpinning other deployment"
                sysrootDeploymentSetPinned sysroot pin False
              _ -> putStrLn "more than one deployment already pinned"
            unless dryrun $ do
              putStrLn "pinning current deployment"
              sysrootDeploymentSetPinned sysroot deploy True
