#/bin/bash

apt update -y
apt install dkms -y
apt install pve-headers-$(uname -r)

wget https://files.gitee.com/group1/M00/2A/41/CgAAEmKoM0qAbCe0AAFmIIVWJpw326.deb?token=d3bfd41b5d0403a6b61c41e450b7bbf4&ts=1655190912&attname=pve-realtek-r8125-dkms_9.009.01-1_amd64.deb&disposition=attachment
dpkg -i pve-realtek-r8125-dkms_9.009.01-1_amd64.deb