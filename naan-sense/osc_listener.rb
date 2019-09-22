live_loop :oscsomething do
use_real_time
v = sync "/osc*/volume"
play v
sleep 1
end
