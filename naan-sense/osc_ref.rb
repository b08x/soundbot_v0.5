#!/usr/bin/env ruby

home = ENV['HOME']

studio = File.join(home, "studio")
sessions = File.join(studio, "sessions")
recordings = File.join(studio, "recordings")


#start jack & alsa bridge

#aj-snapshot or jackpatch to save connections
#perhaps run snapshot after all the things are loaded...

# check if directory exists, if not create them

# have a list of sessions, prompt to select or start new
# http://non.tuxfamily.org/nsm/API.html


# studio/
#   sessions/
#     screencasts/
#       presets
#       drumkits/h2songs
#     live
#     albums
#
#   recordings/
#     screencasts
#     live
#     albums
#
# for session files, copy ~/studio/sessions/default to desired category
#   e.g. cp -rv default/ screencasts/sessionmgmt
# then create the corresponding folder in recordings;
#   /home/b08x/studio/recordings/screencasts/sessionmgmt

#TODO
#have app open with config file e.g qsampler session-file.lscp

#sort drum samples into sfz
#bass drums, snares, etc


# start nsmd - nsmd --osc-port $port --session-root $session_root

# start non-session-manager

# tell nsmd to open the session called "keyboardstuff".
# the arguement before the session name excepts to have specified
# the type of bits we're sending. e.g. s for string, i for integer, etc

# oscsend localhost 14758 /nsm/server/open s keyboardstuff


# "%20" represents a space between words (as is this a url apparently)
oscsend localhost 9090 /strip/master/Mono%20Pan/Pan f 0.4
oscsend localhost 9090 /strip/master/Mono%20Pan/Pan f 0.2
oscsend localhost 9090 '/strip/master/Gain/Gain%20(dB)' f 1
oscsend localhost 9090 '/strip/master/Gain/Gain%20(dB)' f 0.9
oscsend localhost 9090 '/strip/master/Gain/Gain%20(dB)' f 0.98
oscsend localhost 9090 '/strip/master/Gain/Gain%20(dB)' f 0.91

oscsend localhost 9090 '/strip/master/C*%20Eq4p%20-%204-band%20parametric%20equaliser/a.f%20(Hz)' f 1
oscsend localhost 9090 '/strip/master/C*%20Eq4p%20-%204-band%20parametric%20equaliser/a.f%20(Hz)' f 0
oscsend localhost 9090 '/strip/master/C*%20Eq4p%20-%204-band%20parametric%20equaliser/a.f%20(Hz)' f 0.01

#TODO some sort of conversion e.g. 0.01 to Hz
# perhaps not....
# add 'usncaled at the end followed by the specifc number (insead of a float between 0.0 and 1.0)'
oscsend localhost 9090 '/strip/master/C*%20Eq4p%20-%204-band%20parametric%20equaliser/a.f%20(Hz)/unscaled' f 1400
# http://non.tuxfamily.org/wiki/UsingMidiWithNon

# TODO consistent strip names and effect chaining...
