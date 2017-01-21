#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

# Don't install docs
if ! grep -q '^tsflags=nodocs' /etc/yum.conf ; then
    echo 'tsflags=nodocs' >>/etc/yum.conf
fi

# Fixed URLs instead of mirrorlist
sed -i -e 's/^#\(baseurl=\)/\1/; s/^mirrorlist=/#&/' \
    /etc/yum.repos.d/CentOS-*.repo
