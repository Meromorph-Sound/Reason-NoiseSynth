format_version = "2.0"



front = { 
  Bg = {{ path = "Panel_Front_2U" }},
  deviceName = { offset = { 200, 590}, { path = "Tape_Horizontal_1frames", frames = 1 }},
  patches = { offset = { 200,10},{ path = "PatchBrowseGroup", frames = 1}},
  patch = { offset = {505,20},{ path = "204x10_5x5",frames=1}},
  --
  triggerMode = { offset = {850,200}, {path = "Fader_32_3frames", frames=3}},
  trigger  = { offset = {1290,405}, { path = "Button_53_2frames", frames = 2}},
  triggered = { offset = {1580,25}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  --
  shape = { offset = {2340,100}, { path = "Clicks_9frames", frames = 9}},
  shapeUpDown   = { offset = {2540,137}, { path = "UpDown", frames = 3}},
  --
  lengthDisplay = { offset = { 2770, 120 },{ path = "Display" }},
  pitchDisplay = { offset = { 2770, 220 },{ path = "Display" }},
  --
  pan = { offset = {3350,75}, { path = "Knob_01_63frames", frames = 63}},
  amplitude = { offset = {3350,375}, { path = "Knob_01_63frames", frames = 63}},
  --
  --limiter = { offset = {2800,120}, {path="Knob_51_63frames", frames=63}},
  limiterDisplay = { offset = {2430, 510 },{ path = "Display" }},
  limiterOnOff = { offset = {2430,400}, {path="Button_53_2frames",frames=2}},
  limiterHardSoft = { offset = {2680,400}, {path="Button_53_2frames",frames=2}},
  --
  
  --
  -- OnOff: whether the unit is switched on - push to toggle
  -- Hold: switches stepping on/off - otherwise frozen at current value - push to toggle
  -- Reset: resets the unit to the default value (i.e. offset)  - push to reset
  VCOHold = { offset = {2050,215}, {path="Button_53_2frames",frames=2}}, 
  -- Size: the multiplying factor before it ids added to the click frequency
  -- Offset: the offset added to the click frequency
  lfoFreqDisplay = { offset = { 1290, 210 },{ path = "Display" }},

  threshold = { offset = {1290,310}, {path="Display"}},
  delay = { offset = {1800,310}, {path="Display"}},

}
back = { 
  Bg = {{ path = "Panel_Back_2U" }},
  Placeholder = { offset = { 100, 100 },{ path = "Placeholder" }},
  deviceName = { offset = { 750, 50}, { path = "Tape_Horizontal_1frames", frames = 1 }},
  --
  TriggerIn = { offset = {2105,120}, {path = "SharedCVJack", frames=3} },
  AudioOutLeft = { offset = {1550,120}, { path = "SharedAudioJack", frames = 3}},
  AudioOutRight = { offset = {1750,120},{ path = "SharedAudioJack", frames = 3}}
  }
folded_front = { 
  Bg = {{ path = "Panel_Folded_Front" }}
}
folded_back = { 
  Bg = {{ path = "Panel_Folded_Back" }},
  CableOrigin = { offset = { 1885, 75 }}
}
