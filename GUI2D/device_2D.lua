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
    offset = {500,54},
    { path = "Lamp_10_GREEN_2frames", frames = 2 }
  },
  volume = {
    offset = {700,54},
    { path = "Display_200_50_1frames", frames = 1 }
  },
  alpha = {
    offset = { 1200, 70},
    {path = "Knob_01_63frames", frames=63 }
  },
  exponent = {
    offset = {1500,70},
    {path = "Knob_01_63frames", frames=63 }
  },
  exponent_display = {
    offset = { 1850,40},
    {path="Display_20_1frames", frames=1}
  },
  reload = {
    offset = { 2590, 60},
    {path = "Button_23_2frames", frames=2 }
  },
  seed = {
    offset = { 2600, 220},
    {path = "Fader_25frames", frames=25}
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
