#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Install OS instead of upgrade
install
# Use graphical mode install
graphical
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
# enable networking. use dhcp on device eth0
network --bootproto=dhcp --device=eth0
network --hostname=qubert.syncopatedtech.net
# setting root password
rootpw --iscrypted $6$zkqnpuywirlj420f$Pjgr1kk4HThymRp3rcTS6Mhw6Z4l/cCN6DCq35uZLvH6zHPau8uSn9FxV.Oygj1KMYJC1StLbfc.KwmbUMF8c.
# Firewall configuration
firewall --enabled --service=ssh
# System timezone
timezone America/New_York
# System authorization information
auth  --useshadow  --passalgo=sha512
# System Services
services --enabled="sshd,chronyd,NetworkManager"
# Use CDROM installation media
url --url=http://192.168.41.108/pub/fedora/linux/releases/25/Everything/x86_64/os/
# disable firstboot setup
firstboot --disable
reboot
# SELinux configuration set to disabled as this isn't a server
selinux --permissive
# only use this particular disk
#ignoredisk --only-use=/dev/disk/by-id/usb-MUSHKIN_MKNUFDMH8GB_07AC170325EB1E89-0:0
# clear current mbr and initalize parts, we'll do the disk setup manually
#zerombr
#clearpart --all --initlabel

# for testing
#part / --fstype="ext4" --ondisk=vda --size=12384 --fsoptions="defaults,noatime" --label="root"
#part /var/lib/docker --fstype="ext4" --ondisk=vda --size=8192 --fsoptions="defaults,noatime" --label="docker"
#part /boot --fstype="ext4" --ondisk=vda --size=1024 --fsoptions="defaults,noatime" --label="boot"
#part swap --fstype="swap" --ondisk=vda --size=1024


# add some things to the bootloader; threadirqs for low-latency performance. net.ifnames/biosdevname set to zero so nic interfaces are labeled normally
bootloader --location=mbr --append="threadirqs tsc=reliable divider=10 net.ifnames=0 biosdevname=0 rootdelay=300 console=tty0 console=ttyS0,38400n8"
# create the user
user --name=opsadmin --iscrypted --password $6$8i1wrokgefjnlhz3$C6xdLdUPQ7KP1mjPA9MJEPRIrpK/GVRYLPxwdPnptMAd2J62uoQIjmJWMuN0Ld5q34tuV54mZh6HhtqE.uTUD. --uid=1000 --gid=1000 --gecos="opsadmin"
# start X on boot
xconfig  --startxonboot
# repos to be used during install
repo --name=fedora --baseurl=http://192.168.41.108/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/
repo --name=fedora-updates --baseurl=http://192.168.41.108/pub/fedora/linux/updates/$releasever/$basearch/

repo --name=rpmfusionnonfree --baseurl=http://192.168.41.108/pub/rpmfusion/nonfree/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=rpmfusionnonfreeupdates --baseurl=http://192.168.41.108/pub/rpmfusion/nonfree/fedora/updates/$releasever/$basearch/

repo --name=rpmfusionfree --baseurl=http://192.168.41.108/pub/rpmfusion/free/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=rpmfusionfreeupdates --baseurl=http://192.168.41.108/pub/rpmfusion/free/fedora/updates/$releasever/$basearch/

repo --name=planetccrma --baseurl=http://192.168.41.108/pub/fedora/linux/planetccrma/$releasever/$basearch
repo --name=planetcore --baseurl=http://192.168.41.108/pub/fedora/linux/planetcore/$releasever/$basearch

#%pre

#mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0 /dev/sdc1

#%end

%packages --excludedocs
@core
@ansible-node
@audio
@headless-management
@virtualization
@virtualization-headless

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
yumex-dnf
pciutils
nmap
tigervnc
google-droid-sans-fonts
google-droid-serif-fonts
liberation-serif-fonts
liberation-sans-fonts
terminus-fonts
terminus-fonts-console
freetype-freeworld
google-noto-sans-fonts
google-noto-fonts-common
redshift-gtk

git
gitflow
gitstats
ansible
nodejs

# stuff we need to compile ansible
python-setuptools
python2-paramiko
PyYAML
python-jinja2
python-httplib2
python-six
python-sphinx

claws-mail
claws-mail-plugins-fancy
claws-mail-plugins-archive
claws-mail-plugins-attachwarner
claws-mail-plugins-address-keeper
claws-mail-plugins-pgp

Zim
gtkspell
freemind
ImageMagick
gimp
inkscape
obs-studio
vlc
youtube-dl

keepassx

# to control logitech webcam
gtk-v4l

i3
i3status
dmenu
i3lock
xbacklight
feh
conky
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

kernel-rt
kernel-rt-core
kernel-rt-devel
kernel-rt-modules
kernel-rt-modules-extra
kernel-headers-4.9.11-200.rt9.1.fc25.ccrma
kernel-tools-libs-4.9.11-200.rt9.1.fc25.ccrma
kernel-tools-4.9.11-200.rt9.1.fc25.ccrma

audacity-freeworld
sonic-visualiser-freeworld
jack-audio-connection-kit
fmit
solfege

# from planetccrma
supercollider
supercollider-devel
supercollider-sc3-plugins
linuxsampler
qsampler
linuxsampler-dssi
gigedit
lv2-linuxsampler-plugins
libgig
liblscp

# codecs
gstreamer1-libav
gstreamer1-plugins-bad-free
gstreamer1-plugins-bad-freeworld
gstreamer1-plugins-base
gstreamer1-plugins-good
gstreamer1-plugins-ugly
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-nonfree
gstreamer-plugins-base
gstreamer-plugins-espeak
gstreamer-plugins-fc
gstreamer-plugins-good
gstreamer-plugins-ugly
gstreamer-rtsp
amrnb
amrwb
faac
faad2
flac
lame
libdca
libmad
libmatroska
x264
x265
xvidcore

%end

%post --erroronfail --log=/root/anaconda-post.log
set -eux

cat << 'EOF' >> /etc/sudoers.d/opsadmin
opsadmin ALL=(ALL) NOPASSWD:ALL
Defaults:opsadmin !requiretty
EOF

chmod 0440 /etc/sudoers.d/opsadmin

mkdir -pv /mnt/tmp
mount -t nfs4 -o nolock 192.168.41.108:/backup /mnt/tmp
rsync -avP /mnt/tmp/opsadmin/ /home/opsadmin/
umount /mnt/tmp

cat >> /etc/hosts << EOF
192.168.41.108  bender bender.syncopatedtech.net
192.168.41.108  gitlab gitlab.syncopatedtech.net
EOF


# setup automount service for local nfs 
# TODO: move to ansible task
cat > /etc/auto.master <<EOF
/misc   /etc/auto.misc
/mnt    /etc/auto.mnt
/net    -hosts
+dir:/etc/auto.master.d
+auto.master
EOF

cat > /etc/auto.mnt <<EOF
bender_storage  -fstype=nfs4,rw bender:/storage
bender_backup   -fstype=nfs4,rw bender:/backup
EOF

systemctl enable autofs.service

cat << 'EOF' >> /usr/local/bin/ansible-config-me.sh
#!/bin/sh -
ANSIBLE_HOME="/usr/local/etc/ansible"

mkdir -pv $ANSIBLE_HOME
chmod 775 $ANSIBLE_HOME
chgrp -R opsadmin $ANSIBLE_HOME
setfacl -d -m g::rwx $ANSIBLE_HOME
setfacl -d -m o::rx $ANSIBLE_HOME
chmod g+s $ANSIBLE_HOME

runuser -l opsadmin -c 'ansible-pull -vv -u opsadmin -C development \
-d $ANSIBLE_HOME -i $ANSIBLE_HOME/local \
-U git@gitlab.syncopatedtech.net:devops/ansible.git \
--key-file /home/opsadmin/.ssh/id_rsa --accept-host-key \
--extra-vars="dnf_update=True" 2>&1 | tee /home/opsadmin/run.log'

systemctl disable ansible-config-me.service

shutdown -r now
EOF

chmod 0755 /usr/local/bin/ansible-config-me.sh

# create systemd startup file for ansible first run
cat << 'EOF' >> /usr/lib/systemd/system/ansible-config-me.service
[Unit]
Description=Run ansible-pull at first boot to apply environment configuration
Wants=network-online.target
After=network-online.target
Before=sddm.service

[Service]
ExecStart=/usr/local/bin/ansible-config-me.sh
Type=oneshot

[Install]
WantedBy=multi-user.target
EOF

chmod 0644 /usr/lib/systemd/system/ansible-config-me.service

systemctl daemon-reload
systemctl enable ansible-config-me.service

sed -i 's/ rhgb quiet//g' /etc/default/grub
sed -i 's/GRUB_TERMINAL_OUTPUT="console"/GRUB_TERMINAL_OUTPUT="serial"/g' /etc/default/grub

cat << 'EOF' >> /etc/default/grub
GRUB_SERIAL_COMMAND="serial --speed=38400 --unit=0 --word=8 --parity=no --stop=1"
EOF

grub2-set-default 'Fedora (4.9.11-200.rt9.1.fc25.ccrma.x86_64+rt) 25 (Twenty Five)'
grub2-mkconfig -o /boot/grub2/grub.cfg

# Rewrite limits.conf for jack use
cat > /etc/security/limits.d/95-jack.conf <<EOF
# Default limits for users of jack-audio-connection-kit

@jackuser - rtprio 99
@jackuser - nice -10
@jackuser - memlock unlimited

@pulse-rt - rtprio 20
@pulse-rt - nice -20
EOF

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

cat << 'EOF' >> /etc/udev/rules.d/40-timer-permissions.rules
KERNEL=="rtc0", GROUP="audio"
KERNEL=="hpet", GROUP="audio"
EOF

# might consider moving this to an ansible task. 
cat << 'EOF' >> /usr/local/bin/freqset.sh
#!/bin/sh -
echo 3072 > /sys/class/rtc/rtc0/max_user_freq
#cpupower -c all frequency-set -g performance
EOF

chmod +x /usr/local/bin/freqset.sh

cat << 'EOF' >> /usr/lib/systemd/system/freqset.service
[Unit]
Description=Set max frequency-set for cpu and user rtc
After=network.target

[Service]
ExecStart=/usr/local/bin/freqset.sh
Type=oneshot
 
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable freqset.service

tune2fs -o journal_data_writeback "LABEL=root"

%end