uncomment do
  define :scale_range do |note, scale_type, low, high|
    my_scale = scale(note(note, :octave => 1), scale_type, num_octaves: 7)
    my_scale = my_scale.to_a.delete_if {|x| x < note(low) || x > note(high) }
    [my_scale + my_scale.reverse[1..-2]].flatten
  end

  # # Useful for checking which notes are in the scales
  #  puts scale(:c, :melodic_major).map {|x| SonicPi::Note.resolve_note_name(x) }

  # Issues
  # - Doesn't work with small nos of bars at the moment

  use_debug false
  use_bpm 140
  use_synth :dsaw
  use_synth_defaults sustain: 0.15, release: 0.1

  # SETTINGS
  @scale_type = [:major,
                 :melodic_minor_asc,
                 :minor_pentatonic,
                 :hex_major7,
                 :hex_dorian][0] # These are the scales I typically practice
  @low_note = :f2
  @high_note = :a4
  @no_of_bars = 4 # doesn't work with less than 4 atm
  # END SETTINGS


  @last_note = (note(@low_note) - 1) # lets the scale "find" the starting note
  @dir = :up
  scale_roots = [:c, :db, :d, :eb, :e, :f, :gb, :g, :ab, :a, :bb, :b].shuffle

  # look in the output window to see the order the scales get played in
  puts scale_roots

  4.times {
    sample :drum_cymbal_closed
    sleep 1
  }

  scale_roots.map {|n|
    scale_range(n, @scale_type, @low_note, @high_note).take(8 * @no_of_bars)
  }.each do |my_scale|
    @my_scale = my_scale

    # guards to stop it getting 'stuck'
    @dir = :down if @last_note == @my_scale.max
    @dir = :up if @last_note == @my_scale.min

    if @dir == :up
      while (@my_scale.first <= @last_note)
        @my_scale.rotate!
      end
    else
      @my_scale.rotate!((@my_scale.length/2).ceil)
      while @my_scale.first >= @last_note
        @my_scale.rotate!
      end
    end

    sample :perc_bell, amp: 0.4 # mark change of scale

    @my_scale.cycle.take(8 * @no_of_bars).each do |note|
      if note >= @last_note
        @dir = :up
      else
        @dir = :down
      end

      @last_note = note
      play @last_note
      sleep 0.5
    end
  end
end
