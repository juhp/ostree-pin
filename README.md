# ostree-pin

[![Hackage](https://img.shields.io/hackage/v/ostree-pin.svg)](https://hackage.haskell.org/package/ostree-pin)
[![GPL-3 license](https://img.shields.io/badge/license-GPL--3-blue.svg)](LICENSE)
[![Stackage Lts](http://stackage.org/package/ostree-pin/badge/lts)](http://stackage.org/lts/package/ostree-pin)
[![Stackage Nightly](http://stackage.org/package/ostree-pin/badge/nightly)](http://stackage.org/nightly/package/ostree-pin)
[![Build status](https://secure.travis-ci.org/juhp/ostree-pin.svg)](https://travis-ci.org/juhp/ostree-pin)

## Summary

A small util to "pin" the current ostree deployment.
eg useful on Fedora Silverblue for preserving
the current booted deployment image.

## Install
Needs the Fedora `ostree-devel` packaage or `libostree-dev` (Debian/Ubuntu).

$ cabal install

## Usage

$ sudo ostree-pin

Sets the current deployment to pinned.
