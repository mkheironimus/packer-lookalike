#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

yum -y update

if [ $(rpm -q kernel | wc -l) -gt 1 ] ; then
    reboot &
    sleep 300
fi
