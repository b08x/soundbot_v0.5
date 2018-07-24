#!/usr/bin/env ruby

audio_device = "hw:0"
capture_device = "hw:PCH,0"
playback_device = "hw:PCH,1"

audio_driver = "alsa"
midi_driver = "seq"
realtime = "true"
realtime_priority = 90

# parameters for recording at 96KHz
sample_rate = 96000
frames_period = 512
periods_buffer = 2

# parameters for recording at 48KHz
# sample_rate = 48000
# frames_period = 128
# periods_buffer = 2

# timeout in ms
timeout = 1000

output_channels = 2
input_channels = 2

# set capture only, playback only or both
audio_device_mode = "duplex"

# def set_alsa_params(device,capture,playback,rate,period,nperiods,mdriver=seq)

#   dparams = {}
#   dparams = {device: device, capture: capture, playback: playback, rate: rate, period: period, nperiods: nperiods, midi-driver: mdriver }

#   dparams.each do |param,value|
#     jack_control dps #{param} #{value}
#   end

# end

# def set_engine_params(driver="alsa",name,realtime=True,realtime_priority=90,timeout=1000)
#   eparams = {driver: driver, name: name, realtime: True, realtime-priority: realtime_priority, client-timeout: timeout}

#   jack_control ds #{driver}

#   eparams.each do |param,value|
#     jack_control eps #{param} #{value}
#   end

# end

# def start_sonic_backend
#
#   sonic_pi_tool logs
#   sonic_pi_tool start-server
#
# end


# start_jackd = TTY::Command.new(output: logger)
#
# start_jackd.run "#{god} -c #{File.join(APP_ROOT, 'seshmon.god')} -D"
