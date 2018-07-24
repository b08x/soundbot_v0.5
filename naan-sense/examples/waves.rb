
#
#        Waves by Otto van Zanten
#
#   Video: https://youtu.be/Vhgl7cTHbs4
#

use_bpm 60                                                          # Bpm
CMin7 = [:C3, :G3, :Eb4, :Bb4]                                      #
BMaj7 = [:B3, :Gb3, :Eb4, :Bb4]                                     # The 4 chords
BbMin7 = [:Bb3, :F3, :Db4, :Ab4]                                    #
AMaj7 = [:A3, :E3, :Db4, :Ab4]                                      #
CMin72 = [:C3, :G3, :Eb4, :Bb4, :C4, :G4, :Eb5, :Bb5]               #
BMaj72 = [:B3, :Gb3, :Eb4, :Bb4, :B4, :Gb4, :Eb5, :Bb5]             # The 4 chords + every note 1 octave up
BbMin72 = [:Bb3, :F3, :Db4, :Ab4, :Bb4, :F4, :Db5, :Ab5]            #
AMaj72 = [:A3, :E3, :Db4, :Ab4, :A4, :E4, :Db5, :Ab5]               #
pedal = ring(1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0)                       # Which notes get some extra sustain
sust = 0.75                                                         # Sustain amount
vol = 0.7                                                           # Bass Volume
vol2 = 0.55                                                         # Bass2 Volume
co = 95                                                             # Bass2 Cutoff (Sine Wave was too

# Cue's stuff, controls song structure
in_thread do
  cue :chords1
  sleep 16
  2.times do
    cue :chords1
    cue :bass1
    sleep 16
  end
  2.times do
    cue :chords2
    cue :bass1
    sleep 16
  end
  2.times do
    cue :chords2
    cue :bass2
    sleep 16
  end
  cue :chords1
  sleep 16
  2.times do
    cue :chords2
    cue :bass1
    sleep 16
  end
  cue :pluck1
  sleep 16

  # Final Note:
  use_synth :sine
  play CMin7[0], release: 0.80, sustain: pedal.tick*sust
end

# Picks random notes from the chords at the top, 16 notes * 4 chords
with_fx :normaliser do
  in_thread do
    loop do
      sync :chords1
      16.times do
        play CMin7.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
      16.times do
        play BMaj7.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
      16.times do
        play BbMin7.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
      16.times do
        play AMaj7.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
    end
  end
end

# Picks random notes from the chords again, but this time there's a bit more variation
with_fx :normaliser do
  in_thread do
    loop do
      sync :chords2
      16.times do
        play CMin72.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
      16.times do
        play BMaj72.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
      16.times do
        play BbMin72.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
      16.times do
        play AMaj72.choose, release: 0.80, sustain: pedal.tick*sust
        sleep 0.25
      end
    end
  end
end

# Simple slow bassline, just the lowest notes of the chords
in_thread do
  loop do
    sync :bass1
    use_synth :fm
    play :C2, sustain: 3.5, release: 0.5, amp: vol
    sleep 4
    play :B2, sustain: 3.5, release: 0.5, amp: vol
    sleep 4
    play :Bb2, sustain: 3.5, release: 0.5, amp: vol
    sleep 4
    play :A2, sustain: 3.5, release: 0.5, amp: vol
    sleep 4
  end
end

# More active bassline, it's just going through the notes from the chord but 1 octave down in a set order
in_thread do
  loop do
    sync :bass2
    use_synth :fm
    play :C2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Bb3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Eb3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :G2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :B2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Eb3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Gb2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Bb3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Bb2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Ab3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Db3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :F2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :E2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :A2, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Db3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
    play :Ab3, sustain: 0.875, release: 0.125, amp: vol2, cutoff: co
    sleep 1
  end
end
