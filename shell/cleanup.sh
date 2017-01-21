#! /bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022
if [ "${VERBOSE}" = "true" ] ; then
    set -e -u -x
fi

if [ $(rpm -q kernel-devel | wc -l) -gt 1 ] ; then
    rpm -e $(rpm -q kernel-devel | grep -v kernel-devel-$(uname -r))
fi
if [ $(rpm -q kernel | wc -l) -gt 1 ] ; then
    rpm -e $(rpm -q kernel | grep -v kernel-$(uname -r))
fi

rpm -e --allmatches gpg-pubkey

yum -y remove chef
rm -rf /var/chef /etc/chef

yum -y clean all

for i in /etc/sysconfig/network-scripts/ifcfg-* ; do
    if [ $(basename "${i}") != 'ifcfg-lo' ] ; then
        sed -i -e '/^\(HWADDR\|UUID\)/d' "${i}"
    fi
done

( cd /var/log && rm -rf *.gz anaconda*.log anaconda/* audit/*.gz kickstart \
    rsyslog/* sa/* selfservice/* dracut.log dmesg \
    chef VBoxGuestAdditions.log vboxadd-install*.log )
( cd /tmp && rm -rf .ICE-unix ks-script-* packer-chef-solo vboxguest-* yum.log )
rm -f /root/.bash_history /root/install.log* /root/anaconda-ks.cfg \
    /home/vagrant/.bash_history /etc/ssh/ssh_host_* \
    /etc/udev/rules.d/70-persistent-net.rules
for l in secure messages audit/audit.log boot.log cron kern.log maillog \
	messages secure spooler syslog tallylog wtmp yum.log ; do
    if [ -f "/var/log/${l}" ] ; then
        :> "/var/log/${l}"
    fi
done

:>/var/log/btmp
chgrp utmp /var/log/btmp
chmod 640 /var/log/btmp

case "${PACKER_BUILDER_TYPE}" in
    virtualbox-*)
        fixfiles -F restore
        ;;
    *)
        echo 'No SELinux relabel on this builder.'
        ;;
esac
