

run_file "/home/b08x/studio/seshmon/lib/drums/euclid_distrib_defs.rb"


# use_bpm(60)
#
# live_loop(:hh) do
#   with_fx :level, amp: 1 do
#     cue :heartbeatx
#     play_hydro_seq(distribute(3, 16), "sim_k02-0")
#   end
# end
#
# live_loop(:bd) do
#   sync :heartbeatx
#
#   #play_sample_for_sequence(distribute(7, 16), :drum_bass_hard)
#   play_hydro_seq(distribute(7, 16), "VP Kick 2")
#
# end
#
# live_loop(:sn) do
#   with_fx :level, amp: 0.8 do
#     cue :heartbeatx
#
#     # play_sample_for_sequence(distribute(2, 16).to_a.rotate(4), :drum_snare_hard)
#     play_hydro_seq(distribute(2, 16).to_a.rotate(4), "sim_k02-0_1")
#
#   end
# end

with_fx :reverb, room: 0.4, damp: 0.6, pre_mix: 0.8 do
  with_fx :level, amp: 0.10 do
    with_fx :rhpf, cutoff: 28 do
      live_loop(:hh) do
        with_fx :level, amp: 0.30 do
          cue :heartbeatx
          #play_hydro_seq(distribute(3, 16), "sim_k02-0")
          with_fx :pan, pan: -0.8, pan_slide: 1.5 do |balls|
            control balls, pan: 0.8
            play_hydro_seq(distribute(9, 16), "chh_2")
          end


        end
      end

      live_loop(:bd) do
        sync :heartbeatx

        with_fx :band_eq, freq: 38, db: 6, res: 0.6 do
          play_hydro_seq(distribute(7, 16), "VP Kick 2")
        end

      end

      live_loop(:sn) do
        with_fx :level, amp: 0.8 do
          cue :heartbeatx

          play_hydro_seq(distribute(2, 16).to_a.rotate(4), "sim_k02-0_1")
        end
      end
    end
  end
end
