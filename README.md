# ostree-pin
[![Hackage](https://img.shields.io/hackage/v/ostree-pin.svg)](https://hackage.haskell.org/package/ostree-pin)
[![GPL-3 license](https://img.shields.io/badge/license-GPL--3-blue.svg)](LICENSE)

## Summary
A small utility to move the ostree "pin" to the current ostree deployment.
eg useful on Fedora Silverblue for preserving
the current booted deployment image.
It can be run before booting into a new staged deployment,
or afterwards using the `--rollback` option.

## Help
`$ ostree-pin --version`
```
0.1.1
```
`$ ostree-pin --help`
```
Tool to update ostree deployment pin

Usage: ostree-pin [--version] [-n|--dryrun] [-p|--rollback]

  See https://github.com/juhp/ostree-pin#readme

Available options:
  -h,--help                Show this help text
  --version                Show version
  -n,--dryrun              Dry run
  -p,--rollback            Pin previous (rollback) deployment
```

If you forgot to pin the previous deployment before booting into a newer one,
you can use `--rollback` to pin it from the newer deployment.

## Usage
```shellsession
$ sudo ostree-pin
removing previous pin
pinning current deployment
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
