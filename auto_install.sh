#/bin/bash

apt update -y
apt install -y dkms
# apt install -y pve-headers-$(uname -r)
for i in /boot/System.map*
do
  echo "install pve-headers-${i#*map-}"
  apt install -y pve-headers-${i#*map-}
done

# wget https://gitee.com/fibreyu/pve_realtek_r8125_dkms/attach_files/1126181/download/pve-realtek-r8125-dkms_9.009.02-1_amd64.deb -O driver.deb
wget https://gitee.com/fibreyu/pve_realtek_r8125_dkms/releases/download/v9.010.01/pve-realtek-r8125-dkms_9.010.01-1_amd64.deb -O /tmp/driver.deb

# dpkg -i ./driver.deb
apt install -f /tmp/driver.deb -y

# rm -rf ./driver.deb
rm -rf /tmp/driver.deb

echo "reboot to apply new driver!"