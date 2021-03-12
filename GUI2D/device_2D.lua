format_version = "2.0"



front = { 
  Bg = {{ path = "Panel_Front_2U" }},
  deviceName = { offset = { 200, 590}, { path = "Tape_Horizontal_1frames", frames = 1 }},
  patches = { offset = { 200,10},{ path = "PatchBrowseGroup", frames = 1}},
  patch = { offset = {505,20},{ path = "204x10_5x5",frames=1}},
  --
  triggerMode = { offset = {1650,250}, {path = "Fader_32_3frames", frames=3}},
  trigger  = { offset = {1580,25}, { path = "Button_53_2frames", frames = 2}},
  triggered = { offset = {1980,445}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  --
  shape = { offset = {900,210}, { path = "Clicks_9frames", frames = 9}},
  shapeUpDown   = { offset = {1100,247}, { path = "UpDown", frames = 3}},
  --
  lengthDisplay = { offset = { 900, 470 },{ path = "Display" }},
  pitchDisplay = { offset = { 900, 585 },{ path = "Display" }},
  pan = { offset = {3350,75}, { path = "Knob_01_63frames", frames = 63}},
  amplitude = { offset = {3350,375}, { path = "Knob_01_63frames", frames = 63}},
  --
  --limiter = { offset = {2800,120}, {path="Knob_51_63frames", frames=63}},
  limiterDisplay = { offset = {1300, 430 },{ path = "Display" }},
  limiterOnOff = { offset = {1300,210}, {path="Button_53_2frames",frames=2}},
  limiterHardSoft = { offset = {1300,300}, {path="Button_53_2frames",frames=2}},
  --
  
  --
  -- OnOff: whether the unit is switched on - push to toggle
  -- Hold: switches stepping on/off - otherwise frozen at current value - push to toggle
  -- Reset: resets the unit to the default value (i.e. offset)  - push to reset
  VCOModOnOff = { offset = {2270,245}, {path="Button_53_2frames",frames=2}}, 
  VCOHold = { offset = {2440,245}, {path="Button_53_2frames",frames=2}}, 
  -- Size: the multiplying factor before it ids added to the click frequency
  -- Offset: the offset added to the click frequency
  lfoFreqDisplay = { offset = { 1980, 260 },{ path = "Display" }},

  threshold = { offset = {1980,360}, {path="Display"}},
  delay = { offset = {2260,360}, {path="Display"}},

}
back = { 
  Bg = {
    { path = "Panel_Back_2U" },
  },
  Placeholder = {
    offset = { 100, 100 },
    { path = "Placeholder" },
  },
  TriggerIn = { offset = {2000,120}, {path = "SharedCVJack", frames=3} },
  enabled = { offset = {2100,145}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  --
  LFOModulatorIn = {
    offset = {2400,300},
    {path = "SharedCVJack", frames=3}
  },
  LFOModulatorTrim = {
    offset = { 2400, 400 },
    { path = "TrimKnob" }
  },
  AudioOutLeft = { offset = {1550,120}, { path = "SharedAudioJack", frames = 3}},
  AudioOutRight = { offset = {1750,120},{ path = "SharedAudioJack", frames = 3}},
  --
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
