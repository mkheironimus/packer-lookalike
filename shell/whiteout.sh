#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

case "${PACKER_BUILDER_TYPE}" in
    virtualbox-*)
        SWAP=$(blkid -o value -l -s UUID -t TYPE=swap || echo '')
        if [ -n "${SWAP}" ] ; then
            DEV=$(readlink -f "/dev/disk/by-uuid/${SWAP}")
            swapoff -a
            dd if=/dev/zero of="${DEV}" bs=1M || echo 'dd done'
            mkswap -U "${SWAP}" "${DEV}"
        fi
        for FS in $(awk '/^\/dev\// { print $2 } {}' /proc/mounts) ; do
            dd if=/dev/zero of="${FS}/EMPTY" bs=1M || echo 'dd done'
            rm -f "${FS}/EMPTY"
            sync
        done
        ;;
    *)
        echo 'No whiteout for this builder.'
esac
