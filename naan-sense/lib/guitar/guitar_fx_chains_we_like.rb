####


with_fx :level, amp: 3 do
  with_fx :hpf, cutoff: 36 do
    with_fx :whammy, transpose: -12 do
      with_fx :distortion, distort: 0.2 do
        live_audio :gitar01, input: 1
      end
    end
  end
end



###


with_fx :level, amp: 1 do
  with_fx :hpf, cutoff: 50 do

    with_fx :band_eq, freq: 63, db: -3, res: 0.1 do

      with_fx :tremolo, phase: 0.25, wave: 3, mix: 0.6 do
        #the higher the damp, the less reverby it will be
        with_fx :reverb, mix: 0.6, damp: 0.3, room: 0.5 do
          with_fx :distortion, mix: 0.4, distort: 0.5 do
            live_audio :gitar01, input: 1
          end
        end
      end
    end
  end
end



####


with_fx :rhpf, cutoff: 52, res: 0.3 do
  with_fx :pan, pan: -0.3, pan_slide: 20 do |p|
    control p, pan: 0.3


      with_fx :echo, mix: 0.2, phase: 0.5, decay: 4 do
        with_fx :flanger, delay: 1 do
          with_fx :distortion, mix: 0.5, distort: 0.6 do
            live_audio :guitar01, input: 1
          end
        end
      end

    end
  end


###################

with_fx :rlpf, cutoff: 72, res: 0.3 do
  with_fx :octaver, super_amp: 0.7, sub_amp: 0.8, subsub_amp: 0.7 do
    with_fx :band_eq, freq: 42, db: 3, res: 0.5 do
      live_audio :guitar01, input: 1
    end
  end
end

#####################


#with_fx :pan, pan: -1, pan_slide: 10 do |p|
#  control p, pan: 1
  with_fx :hpf, cutoff: 42 do
    #with_fx :ring_mod, mix: 0.4, pre_amp: 0.4, freq_slide: 4, freq: 48 do |f|
      #control f, freq: 92
      with_fx :gverb, mix: 0.4, pre_mix: 0.7, spread: 0.4, room: 2, release: 2,
      ref_level: 0.4, tail_level: 0.5 do
        with_fx :distortion, mix: 0.8, distort: 0.4  do
          live_audio :guitar01, input: 1
        end
      end
    #end
  end
#end
