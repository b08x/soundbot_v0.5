use_debug false
use_bpm 90

live_loop :drums do
  #               1 e & a  2 e & a  3 e & a  4 e & a
  cymbals = bools(0,0,0,0, 0,1,0,1, 0,0,0,0, 0,1,0,0)
  hard    = bools(0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0)
  soft    = bools(0,0,0,0, 0,0,0,1, 0,1,0,1, 0,0,0,1)
  kick    = bools(1,0,1,0, 0,0,0,0, 0,0,1,0, 0,1,0,0)
  with_fx :reverb, room: 0.4, damp: 0.1, amp: 1.5 do
    16.times do
      tick
      if cymbals.look then
        sample HYDRO_KITS, "48-SabianRockHatSwish-3", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3
      else
        sample HYDRO_KITS, "42-SabianRockHatClosed-3", amp: 0.5
      end
      sample HYDRO_KITS, "38-PorkpieSnare-3", on: hard.look
      sample HYDRO_KITS, "38-PorkpieSnareEdge-3", on: soft.look
      sample HYDRO_KITS, "36-Ludwig26Kick-3", on: kick.look
      sleep 0.25
    end
  end
end



#HYDRO_KITS, "37-Sidestick2-3"
