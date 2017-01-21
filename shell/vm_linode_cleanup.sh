#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022

if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

yum -y remove \
    bzip2 \
    cpp \
    gcc \
    glibc-devel \
    glibc-headers \
    gssproxy \
    kernel-devel \
    kernel-headers \
    keyutils \
    libbasicobjects \
    libcollection \
    libevent \
    libini_config \
    libmpc \
    libnfsidmap \
    libpath_utils \
    libref_array \
    libtalloc \
    libtevent \
    libtirpc \
    libverto-tevent \
    mpfr \
    nfs-utils \
    quota \
    quota-nls \
    rpcbind \
    tcp_wrappers
