# Welcome to Sonic Pi v3.0.1
# Cloud Beat
#
# Taken from "Beats basteln wie die Großen"
# c't 13/2017
#
# Coded by Pit Noack
# supported by
# Alexander Degraf
# Astrid Hagenguth
# Enrico Mercaldi
# http://www.maschinennah.de/
# mail@pitnoack.de



use_bpm 90

# HISS
live_loop :hiss_loop do
  sample :vinyl_hiss, amp: 0
  sleep sample_duration :vinyl_hiss
end

# SNARE
live_loop :snare_loop do
  sleep ring(2.5, 3)[tick]
  with_fx :lpf, cutoff: 100 do
    sample :tabla_na_s, sustain: 0, release: 0.05, amp: 2
  end
  sleep ring(1.5, 1)[look]
end

# BASSDRUM
define :bassdrum do |note1, duration, note2 = note1|
  use_synth :sine
  with_fx :hpf, cutoff: 100 do
    play note1 + 24, amp: 40, release: 0.01
  end
  with_fx :distortion, distort: 0.1, mix: 0.3 do
    with_fx :lpf, cutoff: 30 do
      with_fx :hpf, cutoff: 55 do
        bass = play note1, amp: 85, release: duration, note_slide: duration
        control bass, note: note2
      end
    end
  end
  sleep duration
end

live_loop :bassdrum_schleife do
  bassdrum 36, 1.5
  if bools(0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0)[tick]
    bassdrum 36, 0.5, 40
    bassdrum 38, 1, 10
  else
    bassdrum 36, 1.5
  end
  bassdrum 36, 1.0, ring(10, 10, 10, 40)[look]
end
