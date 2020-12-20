# ostree-pin

[![Hackage](https://img.shields.io/hackage/v/ostree-pin.svg)](https://hackage.haskell.org/package/ostree-pin)
[![GPL-3 license](https://img.shields.io/badge/license-GPL--3-blue.svg)](LICENSE)
[![Stackage Lts](http://stackage.org/package/ostree-pin/badge/lts)](http://stackage.org/lts/package/ostree-pin)
[![Stackage Nightly](http://stackage.org/package/ostree-pin/badge/nightly)](http://stackage.org/nightly/package/ostree-pin)
[![Build Status](https://travis-ci.com/juhp/ostree-pin.svg?branch=master)](https://travis-ci.com/juhp/ostree-pin)

## Summary

A small utility to "pin" the current ostree deployment.\
eg useful on Fedora Silverblue for preserving
the current booted deployment image.\
The idea is to run this before booting into a new staged deployment.

## Install
Needs the Fedora `ostree-devel` package or `libostree-dev` (Debian/Ubuntu).
Also needs ghc and cabal-install.

$ cabal install

## Usage

$ sudo ostree-pin

Sets the current deployment to pinned, and unpins the previously pinned deployment. If more than one deployment was pinned it doesn't touch them.
