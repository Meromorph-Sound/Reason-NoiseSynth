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
    offset = { 200,10},
    { path = "PatchBrowseGroup", frames = 1}
  },
  patch = {
    offset = {505,20},
    { path = "204x10_5x5",frames=1}
  },
  triggerMode = { offset = {700,120}, {path = "Fader_32_3frames", frames=3}},
  trigger  = { offset = {710,420}, { path = "Button_53_2frames", frames = 2}},
  triggered = { offset = {1580,25}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  --
  threshold = { offset = {1000,120}, {path="Knob_51_63frames", frames=63}},
  delay = { offset = {1000,300}, {path="Knob_51_63frames", frames=63}},
  --
  shape = { offset = {1200,120}, { path = "Clicks_9frames", frames = 9}},
  shapeUpDown   = { offset = {1400,157}, { path = "UpDown", frames = 3}},
  --
  length = { offset = {1550,120}, { path = "Knob_01_63frames", frames = 63}},
  lengthDisplay = { offset = { 1540, 400 },{ path = "Display" }},
  pitch = { offset = {1800,120}, { path = "Knob_01_63frames", frames = 63}},
  pitchDisplay = { offset = { 1790, 400 },{ path = "Display" }},
  pan = { offset = {2050,120}, { path = "Knob_01_63frames", frames = 63}},
  amplitude = { offset = {2300,120}, { path = "Knob_01_63frames", frames = 63}},
  --
  limiter = { offset = {2800,120}, {path="Knob_51_63frames", frames=63}},
  limiterDisplay = { offset = {2800, 240 },{ path = "Display" }},
  limiterOnOff = { offset = {2550,200}, {path="Button_53_2frames",frames=2}},
  limiterHardSoft = { offset = {2550,480}, {path="Button_53_2frames",frames=2}},
  --
  
  --
  -- OnOff: whether the unit is switched on - push to toggle
  -- Hold: switches stepping on/off - otherwise frozen at current value - push to toggle
  -- Reset: resets the unit to the default value (i.e. offset)  - push to reset
  VCOModOnOff = { offset = {1550,580}, {path="Button_53_2frames",frames=2}}, 
  VCOHold = { offset = {1550,500}, {path="Button_53_2frames",frames=2}}, 
  -- Size: the multiplying factor before it ids added to the click frequency
  -- Offset: the offset added to the click frequency
  VCOFreq = { offset = {1250,450}, { path = "Knob_51_63frames", frames = 63}},
  lfoFreqDisplay = { offset = { 1200, 620 },{ path = "Display" }},

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
    offset = {1200,120},
    {path = "SharedCVJack", frames=3}
  },
  LFOModulatorIn = {
    offset = {1450,120},
    {path = "SharedCVJack", frames=3}
  },
  LFOModulatorTrim = {
    offset = { 1450, 250 },
    { path = "TrimKnob" }
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
