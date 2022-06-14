#/bin/bash

apt update -y
apt install dkms -y
apt install pve-headers-$(uname -r)

# wget  | dpkg -i 