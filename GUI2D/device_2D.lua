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
  triggerMode = { offset = {700,120}, {path = "Fader_32_3frames", frames=3}},
  trigger  = { offset = {710,420}, { path = "Button_53_2frames", frames = 2}},
  triggered = { offset = {1580,25}, { path = "Lamp_10_GREEN_2frames", frames=2}},
  --
  threshold = { offset = {1000,120}, {path="Knob_51_63frames", frames=63}},
  delay = { offset = {1000,300}, {path="Knob_51_63frames", frames=63}},
  --
  shape = { offset = {1500,120}, { path = "Clicks_9frames", frames = 9}},
  shapeUpDown   = { offset = {1700,157}, { path = "UpDown", frames = 3}},
  --
  length = { offset = {1850,120}, { path = "Knob_01_63frames", frames = 63}},
  pitch = { offset = {2100,120}, { path = "Knob_01_63frames", frames = 63}},
  --
  limiter = { offset = {2500,120}, {path="Knob_51_63frames", frames=63}},
  limiterOnOff = { offset = {2500,260}, {path="Button_53_2frames",frames=2}},
  --
  pan = { offset = {3100,50}, { path = "Knob_01_63frames", frames = 63}},
  amplitude = { offset = {3350,50}, { path = "Knob_01_63frames", frames = 63}},
  --
  -- OnOff: whether the unit is switched on - push to toggle
  -- Hold: switches stepping on/off - otherwise frozen at current value - push to toggle
  -- Reset: resets the unit to the default value (i.e. offset)  - push to reset
  VCOModOnOff = { offset = {2500,400}, {path="Button_53_2frames",frames=2}}, 
  VCOHold = { offset = {2500,580}, {path="Button_53_2frames",frames=2}}, 
  -- Size: the multiplying factor before it ids added to the click frequency
  -- Offset: the offset added to the click frequency
  VCOFreq = { offset = {2700,400}, { path = "Knob_51_63frames", frames = 63}},
  VCOModMultiplier = { offset = {2700,550}, { path = "Knob_51_63frames", frames = 63}},


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
  ModulatorIn = {
    offset = {1550,120},
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
