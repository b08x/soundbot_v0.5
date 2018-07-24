#!/usr/bin/env ruby

# BASSDRUM
define :bassdrum01 do |note1, duration, note2 = note1|
  use_synth :sine
  with_fx :hpf, cutoff: 100 do
    play note1 + 24, release: 0.01
  end
  with_fx :distortion, distort: 0.1, mix: 0.3 do
    with_fx :lpf, cutoff: 30 do
      with_fx :hpf, cutoff: 55 do
        bass = play note1, release: duration, note_slide: duration
        control bass, note: note2
      end
    end
  end
  sleep duration
end

with_fx :sound_out_stereo, output: 7, amp: 0 do
  2.times do
  bassdrum01 :d3, 0.25
  end
  sleep 1
end
