
# THX Deep Note
# Second draft
# see http://www.earslap.com/article/recreating-the-thx-deep-note.html
time = 10
wait_time = (time / 3)
synths = []
rand_note = -> { rrand(note(:A1), note(:A3)) }




with_fx :nrbpf, amp: 0.25, centre: 70, res: 0.8, pre_mix: 0.2 do
  use_synth :growl
  30.times do
    # collect the synths in an array for controlling later
    synths << lambda { play(rand_note.call, detune: rrand(0,1),
                                      detune_slide: time,
                                      sustain: time,
                                      pan: rrand(0, 1)) }.call
  end

  sleep wait_time

    synths.each do |t|

      if (rrand(0.0, 1.0) > 0.5)
        # some go up
        t.control note: 34, note_slide: rrand(wait_time, (time - 2)), detune: 0.1
      else
        # others go down
        t.control note: 28, note_slide: rrand(wait_time, (time - 2)), detune: 0.1
      end

    end

end
