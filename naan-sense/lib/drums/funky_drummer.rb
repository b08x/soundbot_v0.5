# The funky drummer
# The aim here is to experiment with
# a) sequencing drums
# b) playing with 'time feel' which is
#    music-speak for how the beat feels,
#    ranging from robotic (0.0 swing_time)
#    to ultra funky Fresh Prince of Bel Air
#    theme tune style (0.2+ swing_time)

current_bpm = 180.0
use_bpm current_bpm

define :play_kick do |vol|

#with_fx :sound_out, output: 1, amp: 0 do
  sample DRUM_KITS, "36kick", amp: vol
  play :A1 # uncomment for sub rattling bass
#end

end

define :beatz do |kick, index|
  # What's going on here?
  # We're randomizing the loudness of
  # every drum hit to make it sound a bit
  # more like a human drummer.
  # The -> { ... } is called a lambda in Ruby
  # It only gets run when we do 'ghost.call'
  # which means it'll be a *different* random
  # number each time
  ghost = -> { rrand(0.2, 0.3) }
  normal = -> { rrand(0.4, 0.6) }
  accent = -> { rrand(0.8, 0.9) }

  play_kick(normal.call) if kick == 1

  if [1,3,4,5,7,8].include? index
    # Rand here can be really nice
    #with_fx :sound_out, output: 3, amp: 0 do
      sample DRUM_KITS, "37rimshot", amp: ((index % 2) == 0 ? ghost.call : accent.call ) if rand < 0.8
    #end
  end

  with_fx :reverb, mix: 0.5 do
    # Always have snare on 2 and 4
    if index == 5
      #with_fx :sound_out, output: 4, amp: 0 do
        sample DRUM_KITS, "42hat_closed", amp: normal.call
      #end
    end
  end

  # And sometimes on the and of 4
  if (index % 2) == 0
    #with_fx :sound_out, output: 2, amp: 0 do
      sample DRUM_KITS, "38snare", amp: ghost.call if rand < 0.1
    #end

  end
end

define :swing_time do
  # This is the amount of
  # delay added to the offbeats
  # which gives it that swing/funk feel.
  # Play around with it!
  swing_time = 0.2
  return swing_time
end

define :play_beat do
  loop do
    # Two ways of modelling beats - with 0s and 1s OR with indexes
    [1, 0, 0, 0, 0, 0, 1, 0].each.with_index(1) do |kick, index|

      beatz(kick, index)

      if(index % 2) == 0
        # offbeats need to be slightly late for swing
        sleep (0.5 - swing_time)
      else
        sleep (0.5 + swing_time)
      end
    end
  end
end

# Comment this out after the first run
# so that you can re-run and make adjustments
# the code
play_beat
