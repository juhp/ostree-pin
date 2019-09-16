{-# LANGUAGE NoImplicitPrelude #-}
module Main (main) where

import BasicPrelude

import GI.Gio.Objects.Cancellable
import GI.OSTree

main :: IO ()
main = do
  sysroot <- sysrootNewDefault
  sysrootLoad sysroot noCancellable
  booted <- sysrootGetBootedDeployment sysroot
  pinned <- deploymentIsPinned booted
  if pinned then return ()
    else do
    deploys <- sysrootGetDeployments sysroot
    pins <- filterM deploymentIsPinned deploys
    case pins of
      [] -> return ()
      [pin] -> sysrootDeploymentSetPinned sysroot pin False
      _ -> putStrLn "more than one deployment already pinned"
  sysrootDeploymentSetPinned sysroot booted True
