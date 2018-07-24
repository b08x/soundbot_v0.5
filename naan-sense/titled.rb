scales_arr = []
2.times do
  scl = scale([:c5, :c6].choose, :harmonic_minor, num_octaves: 2)
  scales_arr << mk_rand_scale(scl, 3)
end

live_loop :transmission, auto_cue: false do

  use_synth :blade
  autostop(rrand max_t*0.8, max_t) # (rrand_i 5, 7)
  chd = chord(:d2, :M, num_octaves: 2).shuffle
  notes = scales_arr.choose

  slp = [[3,3,2], [4,4,2], [6,6,3], [8,8,4]].choose.ring
  puts "Transmission pattern: #{slp}"

  (slp.size * 2).times do
    att, sus, rel = slp.tick * 0.3, slp.look * 0.2, slp.look * 0.5
    phase = [0.25, 0.5, 0.75, 1].choose
    mod_frq = rdist(0.0125, 0.5) * midi_to_hz(chd.tick(:chd))
    with_fx :echo, mix: 0.25, phase: 1.5, decay: 4 do
      with_fx :ring_mod, freq: mod_frq do
        with_fx :slicer, mix: rrand(0.125, 0.75),
        smooth_up: phase * 0.5, smooth_down: phase * 0.125, phase: phase do
          play notes.look, amp: 0.09, attack: att,
            sustain: sus, release: rel, cutoff: 85
          sleep slp.look
        end
      end
    end
  end
  sleep [4, 8, 12, 16, 20, 32].choose
end
