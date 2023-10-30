# ostree-pin
[![Hackage](https://img.shields.io/hackage/v/ostree-pin.svg)](https://hackage.haskell.org/package/ostree-pin)
[![GPL-3 license](https://img.shields.io/badge/license-GPL--3-blue.svg)](LICENSE)

## Summary
A small utility to "pin" the current ostree deployment.
eg useful on Fedora Silverblue for preserving
the current booted deployment image.
The idea is to run this before booting into a new staged deployment.

## Help
`$ ostree-pin --help`
```
Tool to update pinned ostree deployment

Usage: ostree-pin [-n|--dryrun] [-p|--rollback]

  See https://github.com/juhp/ostree-pin#readme

Available options:
  -h,--help                Show this help text
  -n,--dryrun              Dry run
  -p,--rollback            Pin previous (rollback) deployment
```

## Install
Needs the Fedora `ostree-devel` package (or better `ghc-gi-ostree-devel`)
or `libostree-dev` (Debian/Ubuntu). Also needs ghc and cabal-install (or stack).
```
$ cabal install
```
or from git:
```
$ stack install
```

## Usage
```
$ sudo ostree-pin
```
Sets the current deployment to pinned,
and unpins the previously pinned deployment.
If more than one deployment was pinned it doesn't touch them.

## Contribute
ostree-pin is distributed under the GPL license version 3 or later.

Contributions are welcome at <https://github.com/juhp/ostree-pin>
