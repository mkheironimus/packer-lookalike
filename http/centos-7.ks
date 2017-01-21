install
cdrom
lang en_US.UTF-8
keyboard us
network --bootproto=dhcp
rootpw vagrant
firewall --disabled
selinux --enforcing
timezone UTC
unsupported_hardware
bootloader --location=mbr --append="crashkernel=auto"
text
skipx
auth --enableshadow --passalgo=sha512 --kickstart
firstboot --disabled
reboot
user --name=vagrant --plaintext --password vagrant
zerombr
clearpart --all --initlabel
part / --fstype=xfs --size=1 --grow --asprimary

%packages --nobase --ignoremissing --excludedocs
# vagrant needs this to copy initial files via scp
openssh-clients
sudo
kernel-headers
kernel-devel
gcc
make
perl
nfs-utils
net-tools
-fprintd-pam
-intltool

# make packages match linode
-audit-libs-python
-checkpolicy
-chrony
-jbigkit-libs
-libcgroup
-libjpeg-turbo
-libsemanage-python
-libtiff
-libwebp
-libyaml
-policycoreutils-python
-python-backports
-python-backports-ssl_match_hostname
-python-boto
-python-chardet
-python-cheetah
-python-IPy
-python-jsonpatch
-python-jsonpointer
-python-markdown
-python-pillow
-python-prettytable
-python-pygments
-python-requests
-python-setuptools
-python-six
-python-urllib3
-PyYAML
-setools-libs
avahi-autoipd
avahi-libs
gpm-libs
iotop
lm_sensors-libs
lsof
mtr
nano
sysstat
vim-common
vim-enhanced
vim-filesystem
wget
whois
%end

%post
# Make sudo work.
echo 'Defaults:root !requiretty' >/etc/sudoers.d/norequiretty
echo 'Defaults:%vagrant !requiretty' >/etc/sudoers.d/vagrant
echo '%vagrant ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers.d/vagrant
# kdump is usually not useful in test images.
systemctl disable kdump
%end
