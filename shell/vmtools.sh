#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022

if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

HOME_DIR="${HOME_DIR:-/home/vagrant}"
case "${PACKER_BUILDER_TYPE}" in
    virtualbox-*)
        ver=$(< "${HOME_DIR}/.vbox_version")
        mount -o loop,ro "${HOME_DIR}/VBoxGuestAdditions_${ver}.iso" /mnt
        yum -y install bzip2 perl
        bash /mnt/VBoxLinuxAdditions.run || echo 'VBox additions done'
        umount /mnt
        rm -f "${HOME_DIR}/VBoxGuestAdditions_${ver}.iso"
        ;;
    *)
        echo 'No VM tools to install.'
esac
