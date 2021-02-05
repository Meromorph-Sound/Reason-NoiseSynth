format_version = "2.0"



front = { 
  Bg = {
    { path = "Panel_Front_2U" }
  },
  deviceName = {
    offset = { 100, 575},
    { path = "Tape_Horizontal_1frames", frames = 1 },
  },
  patches = {
    offset = { 2400,100},
    { path = "PatchBrowseGroup", frames = 1}
  },
  patch = {
    offset = {2700,100},
    { path = "204x10_5x5",frames=1}
  },
  shape = { offset = {500,50}, { path = "Clicks_9frames", frames = 9}},
  shapeUpDown   = { offset = {700,100}, { path = "UpDown", frames = 3}},
  triggerMode = { offset = {500,350}, {path = "Fader_32_3frames", frames=3}},
  trigger  = { offset = {200,150}, { path = "Button_53_2frames", frames = 2}},
  triggered = { offset = {212,50}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  pitch = { offset = {1200,100}, { path = "Knob_01_63frames", frames = 63}},
  length = { offset = {1500,100}, { path = "Knob_01_63frames", frames = 63}},
  pan = { offset = {1800,100}, { path = "Knob_01_63frames", frames = 63}},
  amplitude = { offset = {2100,100}, { path = "Knob_01_63frames", frames = 63}},
  
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
