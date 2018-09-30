install
lang en_US.UTF-8
keyboard us
auth --enableshadow --passalgo=sha512
services --enabled=sshd,ntpd
eula --agreed

network  --bootproto=dhcp
network --hostname=soundbot02.loaf.org
rootpw --iscrypted $6$1afAakmzvQS0GxqQ$1dd8A1CYihv5pk0YlZap/yRPXnH33zX8.NhAGFVsDTDu6FQOGEgkc6/Mr.tYehmPmDMu7BUHlAzqaHe8SLoFr/
--url="http://download.fedoraproject.org/pub/fedora/linux/releases/28/Everything/$basearch/os/"
firewall --enabled --service=ssh
selinux --disabled
timezone --utc America/New_York
firstboot --disable
skipx
graphical

bootloader --location=mbr --append="ipv6.disable=1 net.ifnames=0 biosdevname=0"

reboot

repo --name=fedora-updates --baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/28/$basearc
h/

repo --name=rpmfusionfree --baseurl=http://download1.rpmfusion.org/free/fedora/releases/28/Everything/$basearch/os/
repo --name=rpmfusionfreeupdates --baseurl=http://download1.rpmfusion.org/free/fedora/updates/28/$basearch/

repo --name=rpmfusionnonfree --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/28/Everything/$basearch/os/
repo --name=rpmfusionnonfreeupdates --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/28/$basearch/

repo --name=planetccrma --baseurl=http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetccrma/28/$basearch
repo --name=planetcore --baseurl=http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetcore/28/$basearch


%packages
@^minimal-environment
@ansible-node
chrony

planetccrma-repo
rpmfusion-free-release
rpmfusion-nonfree-release

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
nodm
mesa-dri-drivers
xorg-x11-drv-evdev
xorg-x11-drv-fbdev
xorg-x11-drv-synaptics
vim-enhanced
xbindkeys
nitrogen
xorg-x11-utils

kernel-rt
kernel-rt-core
kernel-rt-devel
kernel-rt-modules
kernel-rt-modules-extra
kernel-headers-4.16.18-300.rt11.1.fc28.ccrma
kernel-tools-libs-4.16.18-300.rt11.1.fc28.ccrma
kernel-tools-4.16.18-300.rt11.1.fc28.ccrma
%end

%post --erroronfail --log=/root/anaconda-post.log
set -eux

sed -i -e 's|^# %wheel\tALL=(ALL)\tNOPASSWD: ALL|%wheel\tALL=(ALL)\tNOPASSWD: ALL|; s|^Defaults    requiretty|#&|' /etc/sudoers

sed -i 's/ rhgb quiet//g' /etc/default/grub

grub2-set-default 'Fedora (4.16.18-300.rt11.1.fc28.ccrma.x86_64+rt) 27 (Twenty Seven)'
grub2-mkconfig -o /boot/grub2/grub.cfg

# Tune Linux vm.dirty_background_bytes (IMAGE-439)
# The following tuning causes dirty data to begin to be background flushed at
# 100 Mbytes, so that it writes earlier and more often to avoid a large build
# up and improving overall throughput.
cat << 'EOF' >> /etc/sysctl.conf
vm.swappiness = 10
vm.dirty_background_bytes=100000000
fs.inotify.max_user_watches=524288
dev.hpet.max-user-freq=3072
EOF

systemctl set-default multi-user.target

tune2fs -o journal_data_writeback "LABEL=root"
%end
