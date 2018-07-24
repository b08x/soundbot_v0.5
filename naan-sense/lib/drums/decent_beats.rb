live_loop :ahee do
  sample DRUM_KITS, "EE_Hat_Op_Dirty" if spread(1,8).tick

  # sample electric_empire, "EE_Hat_Cl_Dirty" if spread(5,11).look
  #
  sample DRUM_KITS, "kick_2" if spread(3,8).look

  sample DRUM_KITS, "kick_3" if spread(7,11).look

  sample DRUM_KITS, "kick_4" if spread(1,4).look

  sleep 0.25

end


##########_---------------------
