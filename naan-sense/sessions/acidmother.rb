



live_audio :hydrogen, input: 3


live_audio :gitar, input: 1




comment do
  
  
  
  
  live_audio :acidmother do
    
    
    with_fx :level, amp: 0, amp_slide: 4 do |a|
      control a, amp: 0.45
      
      16.times do |x|
        
        
        sample SAMPLES, "888888-BitifulBlueExtasy", lpf: 110, hpf: 30, slice: x, num_slices: 16
        sample_duration SAMPLES, "888888-BitifulBlueExtasy", lpf: 110, hpf: 30
        
      end
      
      
    end
  end
  
  
end