format_version = "2.0"


front = { 
  Bg = {{ path = "Panel_Front_2U" }},
  patches = { offset = { 500,80},{ path = "PatchBrowseGroup", frames = 1}},
  patch = { offset = {805,80},{ path = "PatchName_1frames",frames=1}},
  deviceName = { offset = { 3100, 80}, { path = "Tape_Horizontal_1frames", frames = 1 }},
  note = { offset = {2000,88}, { path = "Lamp_10_GREEN_2frames", frames = 2 }},
  volume = { offset = {2200,92}, { path = "Display_200_50_1frames", frames = 1 }},
  alpha = { offset = { 500, 305}, {path = "Knob_01_63frames", frames=63 }},
  exponent = { offset = {800,305}, {path = "Knob_01_63frames", frames=63 }},
  mutate = { offset = {1900,305}, {path = "Knob_01_63frames", frames=63 }},
  mutateRange = { offset = {2236,345}, { path = "upDown", frames=3 }},
  mutateRangeDisplay = { offset = {2140,355}, {path = "Display_6frames",frames=6 }},
  exponent_display = { offset = { 1150,280}, {path="Display_20_1frames", frames=1}},
  reload = { offset = { 2600, 330}, {path = "Button_23_2frames", frames=2 }},
  seed = { offset = { 2600, 490}, {path = "Fader_25frames", frames=25}},
  range = { offset = { 3195,345 }, { path = "upDown", frames = 3}},
  rangeDisplay = { offset = {3100,355}, { path = "Display_24frames", frames=24}}
}
back = { 
  Bg = {{ path = "Panel_Back_1U" }},
  Placeholder = { offset = { 2000, 100 }, { path = "Placeholder" }},
  AudioLeft = { offset = {1550,120}, { path = "SharedAudioJack", frames = 3}},
  AudioRight = { offset = {1750,120}, { path = "SharedAudioJack", frames = 3}},
  deviceName = { offset = { 200, 230}, { path = "Tape_Horizontal_1frames", frames = 1 }},
  }
folded_front = { 
  Bg = {{ path = "Panel_Folded_Front" }},
}
folded_back = { 
  Bg = {{ path = "Panel_Folded_Back" }},
  CableOrigin = { offset = { 1885, 75 }},
}
