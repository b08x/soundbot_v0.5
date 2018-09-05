#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use graphical install
graphical
# Do not run the Setup Agent on first boot
firstboot --disable
ignoredisk --only-use=sda,sdb,sdd
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
# Network information
network  --bootproto=static --device=eth0 --gateway=192.168.41.1 --ip=192.168.41.100 --nameserver=192.168.8.41 --netmask=255.255.255.0 --ipv6=auto --activate
network  --bootproto=dhcp --device=eth1 --ipv6=auto
network  --hostname=calculon.syncopatedtech.net
# Root password
rootpw --iscrypted $6$1afAakmzvQS0GxqQ$1dd8A1CYihv5pk0YlZap/yRPXnH33zX8.NhAGFVsDTDu6FQOGEgkc6/Mr.tYehmPmDMu7BUHlAzqaHe8SLoFr/
# SELinux configuration
selinux --permissive
# System services
services --enabled="chronyd"
# System timezone
timezone America/New_York
user --groups=wheel --name=b08x --password=$6$37wmGMjnlfOUNfEx$RJmqp80jrlXw0Cd0tBCSKPyh5RFRIeq8Ny7ycFXBznqFhPhs1ZIQAeMJlbIsaxHvmQdXCXBfe0z9h0.JW8Hk5/ --iscrypted --uid=1041 --gecos="b08x" --gid=1041
xconfig --startxonboot
# System bootloader configuration
bootloader --location=mbr --boot-drive=sdd --append="net.ifnames=0 biosdevname=0"
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /var/log --fstype="ext4" --ondisk=sdd --size=8192 --label=log
part raid.503 --fstype="mdmember" --ondisk=sdb --size=114472
part swap --fstype="swap" --ondisk=sdd --size=50
part /boot --fstype="ext4" --ondisk=sdd --size=1024 --label=boot
part raid.496 --fstype="mdmember" --ondisk=sda --size=114472
raid / --device=rootraid --fstype="ext4" --level=RAID0 --label=root --chunksize=512 --fsoptions="defaults,noatime,discard,errors=remount-ro" raid.496 raid.503

%packages
@^minimal-environment
@ansible-node
chrony

sudo
htop
iftop
iotop
autofs
net-tools
rsync
wget
mc
lm_sensors
CPUFreqUtility
screen
terminator
mtr
tar
mlocate
unzip
yumex-dnf
pciutils
nmap
tigervnc
ncdu
google-droid-sans-fonts
google-droid-serif-fonts
liberation-serif-fonts
liberation-sans-fonts
terminus-fonts
terminus-fonts-console
google-noto-sans-fonts
google-noto-fonts-common
redshift-gtk

git
gitflow
ansible
nodejs

i3
i3status
dmenu
i3lock
feh
xterm
sddm
mesa-dri-drivers
xorg-x11-drv-evdev
xorg-x11-drv-fbdev
xorg-x11-drv-synaptics
vim-enhanced
xbindkeys
nitrogen
xorg-x11-utils

%end

%addon com_redhat_kdump --disable --reserve-mb='128'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
%end

%post --erroronfail --log=/root/anaconda-post.log
set -eux

cat << 'EOF' >> /etc/sudoers.d/b08x
b08x ALL=(ALL) NOPASSWD:ALL
Defaults:b08x !requiretty
EOF



tune2fs -o journal_data_writeback "LABEL=root"
%end
