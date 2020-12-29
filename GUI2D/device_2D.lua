format_version = "2.0"


front = { 
  Bg = {
    { path = "Panel_Front_1U" },
  },
  deviceName = {
    offset = { 200, 250},
    { path = "Tape_Horizontal_1frames", frames = 1 },
  },
  note = {
    offset = {750,50},
    { path = "Lamp_10_GREEN_2frames", frames = 2 }
  },
  alpha = {
    offset = { 2100, 20},
    {path = "Knob_47_63frames", frames=63 }
  },
  reload = {
    offset = { 3100, 130},
    {path = "Button_21_2frames", frames=2 }
  },
  exponent = {
    offset = {2100,185},
    {path = "Knob_47_63frames", frames=63 }
  },
  exponent_display = {
    offset = { 2300,20},
    {path="Display_20_1frames", frames=1}
  }
  
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
