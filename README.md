# Realtek r8125 DKMS For ProxmoxVE



This provides Realtek r8125 driver for promoxVE in DKMS way so that you can keep the latest driver even after the kernel upgrade.

This project refers to [Realtek r8125 DKMS](https://github.com/awesometic/realtek-r8125-dkms)



## Installation

There are 3 ways to install Realtek r8125 driver for ProxmoxVE.

#### 1. use a deb file builded from this project

download deb file and run 

```bash
wget https://gitee.com/fibreyu/pve_realtek_r8125_dkms/raw/main/auto_install.sh -O auto_install.sh && chmod +x auto_install.sh && bash auto_install.sh
```

or

```bash
apt update -y
apt install -y dkms
apt install -y pve-headers-$(uname -r)
dpkg -i pve-realtek-r8125-dkms*.deb
```

#### 2. use autorun.sh provided by realtek

in this way, if the kernel is updated, driver should be reinstalled

clone this project or download driver source files from [Realtek](https://www.realtek.com/zh-tw/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software) and run 

```bash
apt upgrade -y
apt install -y pve-headers-$(uname -r)

cert_path="/lib/modules/$(uname -r)/build/certs/"

tee "${cert_path}x509.genkey" > /dev/null << 'EOF'
[ req ]
default_bits = 4096
distinguished_name = req_distinguished_name
prompt = no
string_mask = utf8only
x509_extensions = myexts
[ req_distinguished_name ]
CN = Modules
[ myexts ]
basicConstraints=critical,CA:FALSE
keyUsage=digitalSignature
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid
EOF
openssl req -new -nodes -utf8 -sha512 -days 36500 -batch -x509 -config "${cert_path}x509.genkey" -outform DER -out "${cert_path}signing_key.x509" -keyout "${cert_path}signing_key.pem"

for i in /boot/System.map*
do
  # echo ${i#*map-}
  ln -sf $i "/lib/modules/${i#*map-}/build/System.map"
done

cd driver
bash ./autorun.sh
```



#### 3. use dkms install script

clone this project and run 

```bash
# install 
bash ./dkms-install.sh
# remove
bash ./dkms-remove.sh
```



## Debian package build

You can build yourself this after installing some dependencies including `dkms`.

```bash
apt install devscripts debmake debhelper build-essential dkms -y
dpkg-buildpackage -b -rfakeroot -us -uc
```



## LICENSE

GPL-2+ on Realtek driver and the debian packaing.

## References

- [Realtek r8125 driver release page](https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software)
- [ParrotSec's realtek-rtl88xxau-dkms, where got hint from](https://github.com/ParrotSec/realtek-rtl88xxau-dkms)
- [Realtek r8125 DKMS](https://github.com/awesometic/realtek-r8125-dkms)