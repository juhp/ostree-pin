# ostree-pin
Tool to pin current ostree deployment

This tool just updates the pinned ostree deployment
to be the currently booted one.

## Usage

`sudo ostree-pin`

## Notes

In Fedora 37 Silverblue and Kinoite /sysroot is mount read-only.

Until the libostree/rust binding has API for resetting it readonly
it is recommended to run this tool as

`sudo unshare -m ostree-pin`

to revert /sysroot to readonly afterwards.
Though if you reboot right after running ostree-pin it might not matter.

While this utility works for me and has been useful,
and it should be safe enough, please use it at your own risk.
