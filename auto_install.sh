#/bin/bash

apt update -y
apt install -y dkms
apt install -y pve-headers-$(uname -r)

wget https://gitee.com/fibreyu/pve_realtek_r8125_dkms/attach_files/1107282/download/pve-realtek-r8125-dkms_9.009.01-1_amd64.deb -O /tmp/driver.deb

apt install -f /tmp/driver.deb -y
# dpkg -i driver.deb

rm -rf /tmp/driver.deb