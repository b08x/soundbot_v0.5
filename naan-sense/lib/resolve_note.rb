# Useful for checking which notes are in the scales
 puts scale(:c, :melodic_major).map {|x| SonicPi::Note.resolve_note_name(x) }
