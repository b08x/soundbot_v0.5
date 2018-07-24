
# Welcome to Sonic Pi v2.9

#star wars
# 4/4 time

#first bar
#3 quarter notes
play_pattern_timed [ :g2, :g2, :g2], [1]

#dotted eigth note + sixteenth note
play_pattern_timed [ :e2], [0.75], release: 0.75
play_pattern_timed [ :b2], [0.25], release: 0.25

#second bar
#quarter note
play_pattern_timed [ :g2], [1]

#dotted eigth note + sixteenth note
play_pattern_timed [ :e2], [0.75], release: 0.75
play_pattern_timed [ :b2], [0.25], release: 0.25

#half note
play_pattern_timed [ :g2], [2]

#----

#third bar
#3 quarter notes
play_pattern_timed [ :d3, :d3, :d3], [1]

#dotted eigth note + sixteenth note
play_pattern_timed [ :e3], [0.75], release: 0.75
play_pattern_timed [ :b2], [0.25], release: 0.25

#fourth bar
#quarter note
play_pattern_timed [ :gf2], [1]

#dotted eigth note + sixteenth note
play_pattern_timed [ :e2], [0.75], release: 0.75
play_pattern_timed [ :b2], [0.25], release: 0.25

#half note
play_pattern_timed [ :g2], [2], release: 2

#-----
#fifth bar

#quarter note
play_pattern_timed [ :g3], [1], release: 1

#dotted eigth note + sixteenth note
play_pattern_timed [ :g2], [0.75], release: 0.75
play_pattern_timed [ :g2], [0.25], release: 0.25

#quarter note
play_pattern_timed [ :g3], [1], release: 1

#dotted eigth note + sixteenth note
play_pattern_timed [ :fs3], [0.75], release: 0.75
play_pattern_timed [ :fs3], [0.25], release: 0.25

#sixth bar
#tripets - two sixteenth notes + 1 eigth note
play_pattern_timed [ :e3, :ds3], [0.25, 0.25], release: 0.25
play_pattern_timed [ :e3], [0.5], release: 0.5

#half beat rest (eigth rest)
sleep 0.5

#quarter note, quarter note
play_pattern_timed [ :gs2], [1], release: 1
play_pattern_timed [ :cs3], [1], release: 1

#dotted eigth note + sixteenth note
play_pattern_timed [ :c3], [0.75], release: 0.75
play_pattern_timed [ :b2], [0.25], release: 0.25

#-------
#seventh bar
#tripets - two sixteenth notes + 1 eigth note
play_pattern_timed [ :b2, :a2], [0.25, 0.25], release: 0.25
play_pattern_timed [ :b2], [0.5], release: 0.5

#half beat rest (eigth rest)
sleep 0.5

#quarter note, quarter note
play_pattern_timed [ :e2], [1], release: 1
play_pattern_timed [ :gf2], [1], release: 1

#dotted eigth note + sixteenth note
play_pattern_timed [ :e2], [0.75], release: 0.75
play_pattern_timed [ :g2], [0.25], release: 0.25

#eigth bar
#quarter note
play_pattern_timed [ :b2], [1], release: 1

#dotted eigth note + sixteenth note
play_pattern_timed [ :g2], [0.75], release: 0.75
play_pattern_timed [ :b2], [0.25], release: 0.25

#half note
play_pattern_timed [ :d3], [2]
