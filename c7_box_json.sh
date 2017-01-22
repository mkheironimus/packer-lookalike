#! /bin/bash

export PATH=/usr/bin:/bin
umask 022

echo "NAME=${PACKER_BUILD_NAME} TYPE=${PACKER_BUILDER_TYPE}"

STAMP=$(date '+%Y%m%d')
DIR="$1"
if [ -z "${DIR}" -o ! -d "${DIR}" ] ; then
    echo 'First argument should be box directory.'
    exit 1
fi

for BOX in "${DIR}"/*.box ; do
    if [ -f "${BOX}" -a ! -f "${BOX}.json" ] ; then
        cat >"${BOX}.json" <<EOF
{
  "name": "mkheironimus/$(basename "${BOX}" .box | sed -e 's/-virtualbox-[0-9]\{8\}//')",
  "description": "CentOS Linode-lookalike",
  "versions": [{
    "version": "${STAMP}",
    "providers": [{
      "name": "virtualbox",
      "url": "${BOX}",
      "checksum_type": "sha256",
      "checksum": "$(sha256sum "${BOX}" | cut -f1 -d' ')"
    }]
  }]
}
EOF
    fi
done
