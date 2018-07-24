#!/bin/sh


# as user
pulseaudio --kill
sleep 2
systemctl --user stop gvfs-afc-volume-monitor.service && \
systemctl --user stop gvfs-goa-volume-monitor.service && \
systemctl --user stop gvfs-metadata.service && \
systemctl --user stop gvfs-udisks2-volume-monitor.service && \
systemctl --user stop gvfs-daemon.service && \
systemctl --user stop gvfs-gphoto2-volume-monitor.service && \
systemctl --user stop gvfs-mtp-volume-monitor.service

sleep 2

# launch non-session-manager




# time keeper

# sample soundfont, midi file browser

# keyboard inputs to switch modes
