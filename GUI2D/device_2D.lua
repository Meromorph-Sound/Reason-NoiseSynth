format_version = "2.0"



front = { 
  Bg = {
    { path = "Panel_Front_2U" }
  },
  deviceName = {
    offset = { 200, 590},
    { path = "Tape_Horizontal_1frames", frames = 1 },
  },
  patches = {
    offset = { 200,20},
    { path = "PatchBrowseGroup", frames = 1}
  },
  patch = {
    offset = {505,20},
    { path = "204x10_5x5",frames=1}
  },
  shape = { offset = {800,150}, { path = "Clicks_9frames", frames = 9}},
  shapeUpDown   = { offset = {1000,187}, { path = "UpDown", frames = 3}},
  triggerMode = { offset = {3285,200}, {path = "Fader_32_3frames", frames=3}},
  trigger  = { offset = {3295,500}, { path = "Button_53_2frames", frames = 2}},
  triggered = { offset = {1580,25}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  pitch = { offset = {1650,150}, { path = "Knob_01_63frames", frames = 63}},
  length = { offset = {1200,150}, { path = "Knob_01_63frames", frames = 63}},
  pan = { offset = {3150,20}, { path = "Knob_51_63frames", frames = 63}},
  amplitude = { offset = {3350,20}, { path = "Knob_51_63frames", frames = 63}},
  
}
back = { 
  Bg = {
    { path = "Panel_Back_2U" },
  },
  Placeholder = {
    offset = { 100, 100 },
    { path = "Placeholder" },
  },
  TriggerIn = {
    offset = {1750,120},
    {path = "SharedCVJack", frames=3}
  },
  AudioOutLeft = {
    offset = {1950,120},
    { path = "SharedAudioJack", frames = 3},
  },
  AudioOutRight = {
    offset = {2150,120},
    { path = "SharedAudioJack", frames = 3},
  },
  deviceName = {
    offset = { 200, 230},
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
