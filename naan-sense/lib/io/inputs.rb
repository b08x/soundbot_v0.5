def gitar

  with_fx :sound_out, output: 7, amp: 0 do
    live_audio :gitar01, input: 1, stereo: false
  end

end

def sudobass

  with_fx :sound_out, output: 8, amp: 0 do
    live_audio :gitar01, input: 1, stereo: false
  end

end



def yoshimi

  with_fx :sound_out_stereo, output: 9, amp: 0 do
    with_fx :rlpf, cutoff: 114, res: 0.2 do
      with_fx :hpf, cutoff: 23 do
        live_audio :yoshimi, input: 3, stereo: true
      end
    end
  end

end

def linux_sampler

  with_fx :sound_out_stereo, output: 11, amp: 0 do
    with_fx :rlpf, cutoff: 114, res: 0.2 do
      with_fx :hpf, cutoff: 23 do
        live_audio :lsampler, input: 7, stereo: true
      end
    end
  end

end

def mixxx

  with_fx :sound_out_stereo, output: 13, amp: 0 do
    live_audio :mixxx, input: 9, stereo: true
  end

end

def microphone

  with_fx :sound_out_stereo, output: 15, amp: 0 do
      live_audio :microphone, input: 11, stereo: true
  end

end



# gitar
# yoshimi
# linux_sampler
#microphone
#mixxx
#sudobass
