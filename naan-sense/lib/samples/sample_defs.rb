use_bpm 90
use_debug true



in_thread do
  loop do
    cue :tick
    sleep 1
  end
end

in_thread do
  sync :kick
  loop do
      #wtih rlpf between 30-45 will produce deep thumps
      #45 and and above and you start to get more rubber bouncy ball like
      #sync :heartbeat
      2.times do

        with_fx :rlpf, cutoff: 40 do
          sample HYDRO_KITS, "808_Kick_long", attack: 0.05,  pre_amp: 1.5
        end

        sleep 1
      end

      sleep 1

    end

end

load_sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos"

in_thread do
  loop do
    tick
    sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos", onset: look
    cue :kick if look == 32
    sleep 1
  end
end




#puts sample_duration RIB_JAZZ_SAMPS, "0001SummerOverturekronos", onset: x




# def sample_slice(dasample, start, finish)
#   sample dasample, start: start, finish: finish
#   sleep 0.5
# end
#
#
# hellofriend = File.join(RIB_JAZZ_SAMPS, "01hellofriend.wav")



# load_sample hellofriend
#
# with_fx :sound_out, output: 3, amp: 0 do
#
#   with_fx :reverb do
#       sample_slice(hellofriend, 0, 0.125)
#   end
#
#
# end




# puts sample_duration hellofriend
#
# sample hellofriend, start: 0, finish: 0.125,  attack: 1
# sleep 8
#
# sample hellofriend, start: 0.155, finish: 0.25,  attack: 1
# sleep 8
#


#
#
# eggs = File.join(RIB_JAZZ_SAMPS, "donteattheeggs.wav")
#
# puts sample_duration eggs
#
# # "dont eat the eggs"
# sample eggs, start: 0.31, finish: 0.40
#
# # "what"
# sample eggs, start: 0.435, finish: 0.456
#
#
#
#
#
#
# satan = File.join(RIB_JAZZ_SAMPS, "hailsatan.wav")
#
# # "I'm a catholic whore..."
# sample satan, start: 0, finish: 0.125
# # sleep 2
#
# sample satan, start: 0.135, finish: 0.355
# # sleep 2
#
# sample satan, start: 0.365, finish: 0.50
# # sleep 2
#
# sample satan, start: 0.78, finish: 0.85
# # sleep 2
#
# # "and Have a lovely afternoon "
# # or start 0.91 to drop the and
# sample satan, start: 0.88, finish: 0.99
# # sleep 2
#
#
#
#
#
#
# scientist = File.join(RIB_JAZZ_SAMPS, "iamascientist.wav")
#
# # "im a scientist"
# sample scientist, start: 0, finish: 0.185
#
#
# sample scientist, start: 0.212, finish: 0.64
#
# # "when i dont like something about the world i change it"
# sample scientist, start: 0.680, finish: 1
#
#
#
#
