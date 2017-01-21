#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

case "${PACKER_BUILDER_TYPE}" in
    virtualbox-*)
        sed -i -e 's/ rhgb quiet"$/"/' /etc/default/grub
        grub2-mkconfig -o /boot/grub2/grub.cfg
        ;;
esac
