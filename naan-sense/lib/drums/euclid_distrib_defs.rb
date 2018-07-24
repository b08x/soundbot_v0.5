def distribute(accents, total_beats, beat_rotations=0)
    res = []

    total_beats.times do |i|
      # makes a boolean based on the index
      # true is an accent, false is a rest
      res << ((i * accents % total_beats) < accents)
    end

    res.ring
end

# Monkey patching is never a good idea
# just say no kids...
class SonicPi::Core::RingArray
  def as_x_notation
    self.to_a.map {|x| x ? 'x' : '.'}.join(' ')
  end

  def as_beat_groups
    self.to_a.slice_before {|x| x }.to_a.map(&:count).join
  end
end

def play_sample_for_sequence(pattern, sample_name, sleep_time = 0.25)
  pattern.each.with_index do |beat, i|
    sample sample_name if !!beat
    sleep sleep_time
  end
end

def play_hydro_seq(pattern, sample_name, sleep_time = 0.25)
  pattern.each.with_index do |beat, i|
    sample DRUM_KITS, sample_name if !!beat
    sleep sleep_time
  end
end
