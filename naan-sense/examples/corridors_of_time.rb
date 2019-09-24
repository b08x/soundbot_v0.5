# Chrono Trigger Soundtrack - Corridors of Time
# plug this into http://sonic-pi.net/

set_mixer_control! hpf: 21

run_file "/home/b08x/workspace/soundbot_v0.5/naan-sense/lib/bass/wooble.rb"

# global config
use_bpm 110

def play_legato_note(note_value, duration)
  release_duration = duration
  if duration < 1
    release_duration = 1
  end

  play note_value, release: release_duration, amp: 0.65
  sleep duration
end

# arpeggio parts

def arp_d_2
  play_pattern_timed [:d4, :fs4, :b4, :cs5, :fs5, :fs4, :b4, :cs5], [0.5], amp: 0.5
  play_pattern_timed [:e5, :fs4, :b4, :cs5, :fs5, :fs4, :b4, :cs5], [0.5], amp: 0.5
end

def arp_fs_2
  play_pattern_timed [:cs4, :e4, :b4, :cs5, :fs5, :fs4, :b4, :cs5], [0.5], amp: 0.5
  play_pattern_timed [:e5, :fs4, :b4, :cs5, :fs5, :fs4, :b4, :cs5], [0.5], amp: 0.5
end

# bass parts

def bass_d
  play :d2, release: 1.5
  sleep 1.5
  play :d2, release: 1.5
  sleep 1.5
  play :a2
  sleep 0.5
  play :d3
  sleep 0.5
end

def bass_fs_2
  play :fs2, release: 1.5
  sleep 1.5
  play :fs2, release: 1.5
  sleep 1.5
  play :cs3
  sleep 0.5
  play :fs3
  sleep 0.5

  play :fs2, release: 1.5
  sleep 1.5
  play :fs2, release: 1.5
  sleep 1.5
  play :e2
  sleep 1
end

def bass_cs_2
  play :cs2, release: 1.5
  sleep 1.5
  play :cs2, release: 1.5
  sleep 1.5
  play :gs2
  sleep 0.5
  play :cs3
  sleep 0.5

  play :cs2, release: 1.5
  sleep 1.5
  play :cs2, release: 1.5
  sleep 1.5
  play :gs2
  sleep 1
end

def bass_e
  play :e2, release: 1.5
  sleep 1.5
  play :e2, release: 1.5
  sleep 1.5
  play :b2
  sleep 0.5
  play :e3
  sleep 0.5
end

with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
             mid: 0, mid_note: 70, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do


live_audio :yosh, input: 3, stereo: true
live_audio :qsamp, stereo: true, input: 5

#load_sample RIB_JAZZ_SAMPS, "110FollowtheLine"

at 8 do
  # fade in to the forcefield expanding and contracting
  @intro = in_thread(name: :forcefield) do

    ampr = 1

    with_fx :level, amp: 0, amp_slide: 8 do |a|
      control a, amp: ampr


        with_fx :ixi_techno, cutoff_min: 40, cutoff_max: 50, phase: 0.8, res: 0.3 do
        with_fx :ring_mod, freq: rrand(30,34), freq_slide: 5 do |f|
          control f, freq: rrand(30,34)
            wob(32, 3, 16)
          end
        end

    end
  end
end

at 10 do

  with_fx :level, amp: 0.075 do

    with_fx :pitch_shift, pitch: 24 do

      with_fx :whammy, pre_mix: 0.4 do
        with_fx :pan, pan: -0.8 do
          use_synth :chipnoise
          play 60, attack: 4, release: 4
        end

        with_fx :pan, pan: 0.8 do
          use_synth :chipnoise
          play 60, attack: 4, release: 4
        end
      end
    end

  end

end


# at 12 do
#   sample RIB_JAZZ_SAMPS, "110FollowtheLine",
#   slice: 4, num_slices: 10, attack: 0.5, release: 0.5, pan: -1, pan_slide: 4 do |p|
#     control p, pan: 1
#   end
# end


#sample RIB_JAZZ_SAMPS, "110FollowtheLine", slice: 5, num_slices: 10, attack: 0.5, release: 1, rate: -1

#sample RIB_JAZZ_SAMPS, "110FollowtheLine", start: 0.6, finish: 0.72, attack: 2, release: 2.5, rate: -1


at 30 do

  12.times do |x|
    tick

    if look.to_i.odd?
      pside = -0.8
    else
      pside = 0.8
    end

    with_fx :bpf, centre: 120, res: 0.5 do
      with_fx :reverb, room: 0.6, pre_mix: 0.8 do
        sample MAIN_SAMPLE_DIR, "freq01", attack: 0.5, slice: x, num_slices: 12, pan: 0, pan_slide: 0.25, amp: 1.10 do |p|
          control p, pan: pside
        end
      end
    end

    sleep sample_duration MAIN_SAMPLE_DIR, "freq01", attack: 0.5, slice: x, num_slices: 12

  end

end

at 34 do
  with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 1, wave: 3, pre_mix: 0.4 do
    with_fx :reverb, mix: 0.4, room: 0.9 do
      with_fx :level, amp: 0.8 do
        with_fx :mono do
          sample MAIN_SAMPLE_DIR, "robin_williams_snuckthruforcefield", attack: 0.25, rate: 1
        end
      end
    end
  end
end



with_fx :band_eq, freq: 40, db: 0, res: 0.8 do
  live_audio :git01, stereo: true, input: 1, amp: 1
end


at 64 do

  with_fx :rhpf, cutoff: 40, res: 0.3 do
    with_fx :band_eq, freq: 45, res: 0.8, db: -1 do
      with_fx :reverb, room: 0.5, damp: 0.4, pre_mix: 0.6 do

        # live_loop :bass do
        #
        #   use_synth :fm
        #
        #   with_synth_defaults divisor: 2, depth: 4, amp: 0.5 do
        #       bass_d
        #       bass_d
        #       bass_fs_2
        #
        #       # start melody
        #       bass_d
        #       bass_d
        #       bass_cs_2
        #
        #       bass_d
        #       bass_d
        #       bass_fs_2
        #
        #       bass_d
        #       bass_d
        #       bass_cs_2
        #
        #       bass_d
        #       bass_e
        #       bass_fs_2
        #     end
        #   end



      live_loop :kick_drum do
        #sleep 16
        loop do
          with_fx :band_eq, freq: 36, db: 10, res: 0.6 do
            sample MAIN_SAMPLE_DIR, "K-015 Dry 1"
          end
          sleep 0.75
          sample MAIN_SAMPLE_DIR, "37-Sidestick2-2"
          sleep 0.75
          sample MAIN_SAMPLE_DIR, "37-Sidestick2-1"
          sleep 1
          sample MAIN_SAMPLE_DIR, "37-Sidestick2-1"
          sleep 1.5
        end
      end

      live_loop :snare_drum do
        sleep 16
        loop do
          sleep 1
          sample MAIN_SAMPLE_DIR, "Classic-626_Tambourine"
          sleep 1
        end
      end


    end #end reverb
    end # end bandeq
    end #end of rhpf for rhythm section


end #end at 64







end #end of main eq
