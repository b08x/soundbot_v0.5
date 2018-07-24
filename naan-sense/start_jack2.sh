
jack_control start
jack_control ds dummy
jack_control dps rate 48000
jack_control dps nperiods 2
jack_control dps period 32
jack_control dps inchannels 2
jack_control dps outchannels 2
jack_control eps realtime true
jack_control eps realtime-priority 50
jack_control eps clock-source 2

schedtool -R -p 50 -e /usr/bin/a2jmidid && \
schedtool -R -p 50 -e /usr/bin/zita-j2a -d hw:0
