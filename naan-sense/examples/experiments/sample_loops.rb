# Adjust the random seeds to modify the loops as it's running

use_debug false

with_fx :reverb, room: 0.9 do


  live_loop :tab do
    use_random_seed 328
    16.times do
      sample PERCS, "groove", pick, amp: 1-(tick % 2)
      sleep 0.325
    end
  end

  live_loop :tab do
    use_random_seed 666
    16.times do
      sample "tabla_", pick, amp: 0.4
      sleep 0.5
    end
  end


  live_loop :guit, sync: :tab do
    sample "guit", pick
    sleep 4
  end

  live_loop :bd do
    use_random_seed 333
    sleep 0.25
    8.times do
      sample "bd", pick, amp: 2
      sleep 0.5
    end
  end

  live_loop :bass do
    use_random_seed 500
    4.times do
      sample "bass", pick, release: 4, amp: 0.5
      sleep 1
    end
  end

  live_loop :ambi do
    use_random_seed 250
    2.times do
      sample "ambi", pick, release: 4, amp: 3
      sleep 2
    end
  end

  live_loop :elec do
    use_random_seed 1
    4.times do
      sample "elec", pick, release: 4, amp: 1
      sleep 1
    end
  end

  live_loop :elec do
    use_random_seed 285
    3.times do
      sample "loop", pick, attack: 2, release: 2, amp: 1
      sleep 4
    end
  end

  live_loop :elec do
    use_random_seed 420
    6.times do
      sample "perc", pick, amp: 1
      sleep 0.25
    end
  end

live_loop :acoustic do
  use_random_seed 332
  4.times do

    sample "/home/b08x/studio/library/sfz/drums/acous/**", pick, amp: 0.5
    sleep 0.35
  end
end


end
