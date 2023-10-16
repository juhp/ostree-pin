#!/bin/sh

OSTREEPIN=$HOME/.local/bin/ostree-pin

# https://github.com/ostreedev/ostree/issues/2769
#sudo $OSTREEPIN
#fails with "Writing out origin file: open(O_TMPFILE): Read-only file system"
sudo unshare -m /bin/sh -c "mount -o remount,rw /sysroot && $OSTREEPIN $*"
