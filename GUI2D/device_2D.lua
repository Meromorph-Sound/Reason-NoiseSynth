format_version = "2.0"


front = { 
  Bg = {
    { path = "Panel_Front_1U" },
  },
  deviceName = {
    offset = { 185, 215},
    { path = "Tape_Horizontal_1frames", frames = 1 },
  },
  
}
back = { 
  Bg = {
    { path = "Panel_Back_1U" },
  },
  Placeholder = {
    offset = { 100, 100 },
    { path = "Placeholder" },
  },
  AudioLeft = {
    offset = {900,100},
    { path = "SharedAudioJack", frames = 3},
  },
  AudioRight = {
    offset = {1100,100},
    { path = "SharedAudioJack", frames = 3},
  },
  deviceName = {
    offset = { 2000, 215},
    { path = "Tape_Horizontal_1frames", frames = 1 },
  },
  }
folded_front = { 
  Bg = {
    { path = "Panel_Folded_Front" },
  },
}
folded_back = { 
  Bg = {
    { path = "Panel_Folded_Back" },
  },
  CableOrigin = {
    offset = { 1885, 75 },
  },
}
