#!/usr/bin/sh

###
# launch sonicpi logs/server in terminator
#sonic-pi-tool logs

#/home/b08x/workspace/sonic-pi/app/server/ruby/bin/sonic-pi-server.rb
###

#/usr/bin/jackd -dalsa -r44100 -p1024 -n2 -Xseq -D -Chw:PCH,0 -Phw:PCH



jack_control start

jack_control dps device 'hw:0'

jack_control dps rate 41000
jack_control dps period 1024
jack_control dps nperiods 2

#jack_control dps rate 96000
#jack_control dps period 512
#jack_control dps nperiods 2

jack_control dps midi-driver seq

jack_control eps driver alsa
jack_control eps realtime True
jack_control eps realtime-priority 80
jack_control eps verbose True
jack_control eps client-timeout 1000


#
# alsa_out -j "digi" -d hw:PCH,1 &


###
#x42-meter 10 && \
#x42-meter 14 && \
#x42-fil4
x42-meter 1 & \

x42-fil4 & \

zita-rev1 & \

zita-dpl1 -k 2 & \



# schedtool -R -p 50 -e /usr/bin/a2jmidid && \
# schedtool -R -p 50 -e /usr/bin/zita-j2a -d hw:0
