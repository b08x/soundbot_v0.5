# Description : Live CD image for Music Creation Lite Spin
#
# Maintainer(s):
# - David Timms <dtimms a fedoraproject.org>
# - Fedora Music list <music a listsfedoraprojectorg>
# changelog:
#
# 2010-07-26.c set and tell rpm to only install en* locales
# 2010-07-26.b mod beachblit command to zero deleted blocks
# 2010-07-26.a use bleachbit to remove locale data
#   2010-07-25.c
# add path to chkconfig to fix chkconfig not adjusting services in the dest
# 2x gconf commands are having trouble
# booted iso does a text mode login
# fix modprobe file name (avoid deprecation warnings)
# del lilypond to save a heap of kde stuff
#     iso was 762314752 (too big for cd).
# 2010-07-25.b disable gnome-login related sounds
# 2010-07-25.a noipv6, package tweaks
# 2010-07-24.b remove more crud, add the audio packages
# 2010-07-23.a initial test to check size

%include fedora-livecd-desktop.ks
##%include ftp://192.168.16.104/linux/fedora/kickstart/fedora-livecd-desktop.ks

# inlcude on english locale support
lang en.UTF-8


# DVD payload
# part / --size=8192
## testing only
#ignoredisk --drives=sda
#bootloader --location=partition

#repo --name="fedora-updates" --mirrorlist="http://mirrors.fedoraproject.org/#mirrorlist?repo=updates-released-f13&arch=x86_64"


#%packages --ignoremissing
%packages  --instLangs en_US

# unsure how to specify this
#@Sound and Video


# Music Notation
#   included in first past, need to check size
#frescobaldi  # is huge since pulls in half of kde
#lilypond
# inkscape # save some space


# Recording and DAWs
audacity
ardour
#qtractor # not in f13 (see rpmfusion)
rosegarden
#traverso # not in f13 (see rpmfusion)


# Sound Analysis
#praat # not in f13


# Synthesis
# Synthesis | Keyboard
#zynaddsubfx

# Synthesis | Effects
#rakarrack

# Synthesis | Sampling
sooperlooper
fluidsynth
qsynth

# linuxsampler requires another repo, qsampler requires with other libraries
# linuxsampler # not in f13
# qsampler # not in f13

#swami

# Synthesis | Processing / Languages
#supercollider  # not in f13
#pd-extended # not in f13
csound


# Instrument Tuning
#k3guitune


# Sound Server and Configuration
jack-audio-connection-kit
qjackctl

augeas
gconf-editor
bleachbit
gedit

# Audio Driver, Config, Firmware
alsa-firmware
alsa-plugins-jack
alsa-plugins-pulseaudio
alsa-tools
alsa-tools-firmware
alsa-utils
alsamixergui


# gui
multimedia-menus
#   lighten the install
xorg-x11-drv-ati
xorg-x11-drv-ati-firmware
xorg-x11-drv-evdev
xorg-x11-drv-fbdev
xorg-x11-drv-intel
xorg-x11-drv-keyboard
xorg-x11-drv-mouse
xorg-x11-drv-nouveau
xorg-x11-drv-nv
# from the repository that shall not be named:
#xorg-x11-drv-nvidia-195.36.31-2.fc12.x86_64
#xorg-x11-drv-nvidia-libs-195.36.31-2.fc12.x86_64
xorg-x11-drv-synaptics
xorg-x11-drv-vesa
xorg-x11-drv-void
-xorg-x11-drv-vmmouse
-xorg-x11-drv-vmware


# tools to fit if there is space
abrt-gui
openssh-clients
system-config-services

# Removing unnecessary packages from the desktop spin
-abiword
-abrt-desktop
-acpid
-anaconda
-ar9170-firmware
-atmel-firmware
-at-spi
-b43-fwcutter
-b43-openfwwf
-bc
-bind-libs
-bind-utils
-bluez-cups
-brasero
-brasero-nautilus
-caribou
-cdparanoia
-cheese
-cifs-utils
-compiz-gnome
# instead: disable the service in runlevel 4
#-cronie
#-cronie-anacron
#-crontabs # requires exim (mail) @ 1.2MB
-cryptsetup-luks
-cups
-cups-pk-helper
-cyrus-sasl-plain
-deja-dup
-device-mapper-multipath
-device-mapper-multipath-libs
-dmraid
#docbook-dtds # needed for yelp
-dosfstools
-dump
-ed
-efibootmgr
-empathy
-eog
-evince-nautilus
-evolution
-foomatic
-fprintd-pam
-@games
-gcalctool
-gdm-plugin-fingerprint
-gdm-user-switch-applet
-genisoimage
-geoclue
#-ghostscript # installs anyway.
-ghostscript-cups
-gimp
-gimp-data-extras
-gimp-libs
-glx-utils
-gnome-backgrounds
-gnome-bluetooth
-gnome-color-manager
-gnome-disk-utility
#gnome-doc-utils-stylesheets # needed for yelp
-gnome-games
-gnome-media-libs
-gnome-pilot
-gnome-power-manager
-gnome-screensaver
-gnome-themes
-gnome-user-share
-gnome-utils
-gnote
-gok
-gutenprint
-gutenprint-cups
-gvfs-gphoto2
-gvfs-smb
-ibus-anthy
-ibus-chewing
-ibus-gtk
-ibus-hangul
-ibus-m17n
-ibus-pinyin
-ibus-qt
-ibus-rawcode
-icedax
-im-chooser
-imsettings
-imsettings-libs
-iprutils
-iptstate
-ipw2100-firmware
-ipw2200-firmware
-irda-utils
-isomd5sum
-ivtv-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-jomolhari-fonts
-kacst-art-fonts
-kacst-book-fonts
-kacst-decorative-fonts
-kacst-digital-fonts
-kacst-farsi-fonts
-kacst-letter-fonts
-kacst-naskh-fonts
-kacst-office-fonts
-kacst-one-fonts
-kacst-pen-fonts
-kacst-poster-fonts
-kacst-qurn-fonts
-kacst-screen-fonts
-kacst-title-fonts
-kacst-titlel-fonts
-kbd
# frescobaldi pulls this whole series of stuff in, so it is required.
#-kdebase
#-kdebase-runtime-libs
#-kdebluetooth
#-kdefilesystem
#-kdegraphics
#-kdepimlibs
#-kdesdk
-kde-settings
-kpartx
-kross-python
-khmeros-base-fonts
-lftp
-libcanberra-gtk2
-libertas-usb8388-firmware
-linux-atm
-lklug-fonts
-lohit-assamese-fonts
-lohit-bengali-fonts
-lohit-devanagari-fonts
-lohit-gujarati-fonts
-lohit-kannada-fonts
-lohit-oriya-fonts
-lohit-punjabi-fonts
-lohit-tamil-fonts
-lohit-telugu-fonts
-m17n-contrib-assamese
-m17n-contrib-bengali
-m17n-contrib-gujarati
-m17n-contrib-hindi
-m17n-contrib-kannada
-m17n-contrib-maithili
-m17n-contrib-malayalam
-m17n-contrib-marathi
-m17n-contrib-oriya
-m17n-contrib-punjabi
-m17n-contrib-tamil
-m17n-contrib-telugu
-m17n-contrib-urdu
-m17n-db-sinhala
-m17n-db-thai
-mailcap
-man-pages
-mdadm
-mousetweaks
-nautilus-sendto
-nc
-NetworkManager-openconnect
-NetworkManager-openvpn
-NetworkManager-pptp
-NetworkManager-vpnc
-nspluginwrapper
-nss_ldap
-nss-mdns
-ntfs-3g
-ntfsprogs
-openoffice.org-calc
-openoffice.org-core
-openoffice.org-draw
-openoffice.org-graphicfilter
-openoffice.org-impress
-openoffice.org-math
-openoffice.org-writer
-openoffice.org-xsltfilter
-openssh-askpass
-openssh-server
-orca
-PackageKit-command-not-found
-PackageKit-gstreamer-plugin
-padauk-fonts
-paktype-naqsh-fonts
-paktype-tehreer-fonts
-paps
-paps-libs
-paratype-pt-sans-fonts
-parted
-pcmciautils
-pino
-planner
-ppc64-utils
-ppp
-prctl
-preupgrade
-printer-filters
#-pulseaudio
-pulseaudio-module-bluetooth
#-pulseaudio-module-gconf
#-pulseaudio-module-x11
#-pulseaudio-utils
#-pulseaudio-gdm-hooks
-pyxdg
-ql2500-firmware
-rdate
-rdist
-rhythmbox
-rmt
-rp-pppoe
-rsync
-rt61pci-firmware
-rt73usb-firmware
-s390utils
-seahorse
-sendmail
-shotwell
-sil-abyssinica-fonts
-silo
-sil-padauk-fonts
-simple-scan
-smc-meera-fonts
-smolt-firstboot
-sos
-sound-juicer
-sssd
-stix-fonts
-stunnel
-system-config-keyboard
-system-config-printer
-system-config-printer-udev
-talk
-tcpdump
-thai-scalable-waree-fonts
-totem
-totem-mozplugin
-totem-nautilus
-transmission-gtk
-ueagle-atm4-firmware
-un-core-dotum-fonts
-vconfig
-vinagre
-vino
-vlgothic-fonts
-webkitgtk
-wireless-tools
-wodim
-wqy-zenhei-fonts
-wvdial
-xdg-user-dirs-gtk
-xorg-x11-drivers
-yaboot
-zd1211-firmware
-zenity
-zip

%end

%post

# remove email icon from top panel


# give jack-audio-connection-kit a go at cpu
#     in fedora we use jackuser, and it's already set
#     but no users go in the group
#cat > /etc/security/limits.d/99-jack.conf << EOF
#
#@audio - rtprio 100
#@audio - nice -10
#EOF

# use augtool to handle config file changes:
augtool -b << EOF

# set default user group to jackuser=groupid=495  [default is 100=users]
#     now any user added will be in the jackuser group, and have usable rtprio
#     nogo: value is set, but when adding users with useradd, firstboot or
#         sys-conf-users, the users gets a default new own group instead.
#         The groupid also changes between installs (eg now 498).
set /files/etc/default/useradd/GROUP 495

# start in runlevel 4
#     services that could disrupt our realtime latency wont be run
set /files/etc/inittab/id/runlevels 4

# disable ipv6
#     let me know if this is actually used by someone ...
defnode musicspin /files/etc/modprobe.d/blacklist-ipv6.conf/
set /files/etc/modprobe.d/blacklist-ipv6.conf/#comment "created by Music Spin"
set /files/etc/modprobe.d/blacklist-ipv6.conf/blacklist ipv6


save
EOF

# our realtimeish runlevel 4 needs prefdm so that gdm / desktop start
sed -i 's|RUNLEVEL=5|RUNLEVEL=\[45\]|' /etc/init/prefdm.conf
sed -i 's|RUNLEVEL=\[!5\]|RUNLEVEL=\[!45\]|' /etc/init/prefdm.conf

# start abrt daemon
#     we want to know if things aren't going well
/sbin/chkconfig --level 4 abrtd on

# disable other services
#     some of these don't succeed in causing the service to be disabled at rl 4
/sbin/chkconfig --level 4 atd off
/sbin/chkconfig --level 4 avahi-daemon off
/sbin/chkconfig --level 4 cpuspeed off
/sbin/chkconfig --level 4 crond off
/sbin/chkconfig --level 4 ip6tables off
/sbin/chkconfig --level 4 ntpd off
/sbin/chkconfig --level 4 mdmonitor off

# set gnome defaults
#     http://library.gnome.org/users/gconf-editor/stable/defaults-mandatory.html.en
#     http://library.gnome.org/admin/deployment-guide/

# turn off unwanted noises; we're trying to make music
#     this sets system default:
gconftool-2  --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --type bool --set /apps/notification-daemon/sound-enabled 0
gconftool-2  --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --type bool --set /desktop/gnome/sound/event_sounds 0
gconftool-2  --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --type bool --set /apps/gnome-settings-daemon/gtk-modules/canberra-gtk-module 0



# disable gnome apps
#     running gpk-update-icon
# howto delete ~/.config/autostart/gpk-update-icon.desktop ?
mkdir /etc/xdg/disabled/
mv  /etc/xdg/autostart/at-spi-registryd.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/gnome-at-session.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/gnome-keyring-pkcs11.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/gnome-keyring-secrets.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/gnome-keyring-ssh.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/gpk-update-icon.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/pulseaudio.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/restorecond.desktop /etc/xdg/disabled/
mv  /etc/xdg/autostart/sealertauto.desktop /etc/xdg/disabled/

# gnome login sound
#     not sure how to script turning this off...
mv /usr/share/gnome/autostart/libcanberra-login-sound.desktop \
    /usr/share/gnome/autostart/libcanberra-login-sound.desktop.music_spin
# gnome ready to login sound
mv /usr/share/gdm/autostart/LoginWindow/libcanberra-ready-sound.desktop \
    /usr/share/gdm/autostart/LoginWindow/libcanberra-ready-sound.desktop.music_spin


# .xsession-errors:
#     polkit

#     gnome-panel -> fast-user-switch-applet

# that locale data is not really needed, is it ?
#     in debian use localpurge, fedora: bleachbit  #save 100MB ?
#     adding overwrite saved 664797184 - 663748608 = 1048576 bytes.
bleachbit --delete --overwrite system.localizations


%end
