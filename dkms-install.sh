#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must run this with superuser priviliges.  Try \"sudo ./dkms-install.sh\"" 2>&1
  exit 1
else
  echo "About to run dkms install steps..."
fi

DRV_DIR="$(pwd)"
DRV_NAME=r8125
DRV_VERSION=9.009.01

# ===========================  remove old version =====================================================
OLD_DRV_NAME=$(dkms status *r8125* | awk -F ', ' 'NR==1 {print $1}')
OLD_DRV_VERSION=$(dkms status *r8125* | awk -F ', ' 'NR==1 {print $2}'| awk -F ': ' 'NR==1 {print $1}')

if [[ ${OLD_DRV_NAME} != "" ]]; then
  dkms remove ${OLD_DRV_NAME}/${OLD_DRV_VERSION} --all
  rm -rf /usr/src/${OLD_DRV_NAME}-${OLD_DRV_VERSION}
fi

cp -r ${DRV_DIR}/driver /usr/src/${DRV_NAME}-${DRV_VERSION}
cp ${DRV_DIR}/dkms.conf /usr/src/${DRV_NAME}-${DRV_VERSION}/dkms.conf

dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
RESULT=$?

echo "Finished running dkms install steps."

exit $RESULT