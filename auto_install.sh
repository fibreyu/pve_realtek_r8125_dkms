#/bin/bash

apt update -y
apt install -y dkms
apt install -y pve-headers-$(uname -r)

wget https://gitee.com/fibreyu/pve_realtek_r8125_dkms/attach_files/1107282/download/pve-realtek-r8125-dkms_9.009.01-1_amd64.deb -O driver.deb

chmod 777 driver.deb

apt install -f ./driver.deb
# dpkg -i driver.deb

rm -rf driver.deb