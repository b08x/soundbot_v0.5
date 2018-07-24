#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use graphical install
graphical
# Do not run the Setup Agent on first boot
firstboot --disable
#ignoredisk --only-use=sda,sdb,sdd
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
url --url="http://download.fedoraproject.org/pub/fedora/linux/releases/27/Everything/$basearch/os/"
# Network information
network  --bootproto=dhcp
# Root password
rootpw --iscrypted $6$1afAakmzvQS0GxqQ$1dd8A1CYihv5pk0YlZap/yRPXnH33zX8.NhAGFVsDTDu6FQOGEgkc6/Mr.tYehmPmDMu7BUHlAzqaHe8SLoFr/
# SELinux configuration
selinux --disabled
# System services
services --enabled="chronyd"
# System timezone
timezone America/New_York
user --groups=wheel --name=b08x --password=$6$37wmGMjnlfOUNfEx$RJmqp80jrlXw0Cd0tBCSKPyh5RFRIeq8Ny7ycFXBznqFhPhs1ZIQAeMJlbIsaxHvmQdXCXBfe0z9h0.JW8Hk5/ --iscrypted --uid=1041 --gecos="b08x" --gid=1041
xconfig --startxonboot
# System bootloader configuration
#bootloader --location=mbr -append="net.ifnames=0 biosdevname=0"
# Partition clearing information
#clearpart --none --initlabel
# Disk partitioning information

repo --name=fedora-updates --baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/27/$basearch/

repo --name=rpmfusionfree --baseurl=http://download1.rpmfusion.org/free/fedora/releases/27/Everything/$basearch/os/
repo --name=rpmfusionfreeupdates --baseurl=http://download1.rpmfusion.org/free/fedora/updates/27/$basearch/

repo --name=rpmfusionnonfree --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/27/Everything/$basearch/os/
repo --name=rpmfusionnonfreeupdates --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/27/$basearch/

repo --name=planetccrma --baseurl=http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetccrma/27/$basearch
repo --name=planetcore --baseurl=http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetcore/27/$basearch


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
pciutils
nmap
tigervnc
ncdu
nfs-utils
autofs
bind-utils
bash-completion
redshift-gtk

git
ansible

google-droid-sans-fonts
google-droid-serif-fonts
liberation-serif-fonts
liberation-sans-fonts
terminus-fonts
terminus-fonts-console
google-noto-sans-fonts
google-noto-fonts-common

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

Zim
gtkspell
ImageMagick

kernel-rt
kernel-rt-core
kernel-rt-devel
kernel-rt-modules
kernel-rt-modules-extra
kernel-headers-4.14.12-300.rt10.1.fc27.ccrma
kernel-tools-libs-4.14.12-300.rt10.1.fc27.ccrma
kernel-tools-4.14.12-300.rt10.1.fc27.ccrma


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

sed -i 's/ rhgb quiet//g' /etc/default/grub

grub2-set-default 'Fedora (4.14.12-300.rt10.1.fc27.ccrma.x86_64+rt) 27 (Twenty Seven)'
grub2-mkconfig -o /boot/grub2/grub.cfg


tune2fs -o journal_data_writeback "LABEL=root"
%end
