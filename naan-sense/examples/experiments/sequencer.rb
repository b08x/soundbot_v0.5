# Before running this file, first run helpers/sequencer.rb to load the seq function
run_file "/home/b08x/workspace/soundbot/naan-sense/examples/helpers/sequencer.rb"

run_file "/home/b08x/workspace/soundbot/naan-sense/examples/helpers/play-helper.rb"

use_bpm 110

seq [:drum_cymbal,  "o...c...c...c...", # o => :drum_cymbal_open, c => :drum_cymbal_closed
     :drum_bass,    "X.......X.X.....", # X => :drum_bass_hard, x => :drum_bass_soft
     :drum_tom_mid, "....X.......X..."], 0.25

seq [:drum_cymbal,  "c...c..."*2,
     :drum_bass,    "X.X....."*2,
     :drum_tom_mid, "....X..x"*2], 0.25

seq [:drum_cymbal,  "c.c.c.c.c.c.c.c.",
     :drum_bass,    "X.......X.X.....",
     :drum_tom_mid, "....X..x....X..x"], 0.25

seq [:drum_cymbal,  "o.c.c.c.c.c.c...",
     :drum_bass,    "X.......X.X.....",
     :drum_tom_mid, "....X..x....X..x",
     :drum_tom_hi,  "..............x."], 0.25

seq [:drum_cymbal,  "cccc.ccc"*2,
     :drum_bass,    "x.x.x.x."*2,
     :drum_tom_mid, "....x..."*2]*8, 0.25
