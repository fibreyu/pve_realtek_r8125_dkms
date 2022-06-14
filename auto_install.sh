#/bin/bash

apt update -y
apt install dkms -y
apt install pve-headers-$(uname -r)

wget https://gitee.com/fibreyu/pve_realtek_r8125_dkms/attach_files/1094653/download/pve-realtek-r8125-dkms_9.009.01-1_amd64.deb
dpkg -i pve-realtek-r8125-dkms_9.009.01-1_amd64.deb