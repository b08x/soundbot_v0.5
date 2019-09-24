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
        sample PERCS, "alesis_future_54_plunk", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3
      else
        sample PERCS, "alesis_future_56cowbell_fx", amp: 0.5
      end
      sample PERCS, "alesis_future_38snare", on: hard.look
      sample PERCS, "alesis_future_40snare", on: soft.look
      sample PERCS, "alesis_future_35kick", on: kick.look
      sleep 0.25
    end
  end
end



#HYDRO_KITS, "37-Sidestick2-3"
