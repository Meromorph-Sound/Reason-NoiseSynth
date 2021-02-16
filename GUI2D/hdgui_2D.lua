format_version = "2.0"
front = jbox.panel { 
  graphics = { node = "Bg" },
  widgets = {
    jbox.device_name { graphics = {node = "deviceName" }},
    jbox.patch_browse_group { graphics = {node="patches"}},
    jbox.patch_name{
      graphics = { node = "patch" },
      fg_color = { 255,255,255 },
      loader_alt_color = { 55,105,192 },
      center = false,
      text_style = "Bold LCD font",
    },
    jbox.up_down_button{
      graphics={node="shapeUpDown"},
      value="/custom_properties/shape"
    },
    jbox.analog_knob{
      graphics={ node = "shape" },
      value="/custom_properties/shape"
    },
    jbox.analog_knob{
      graphics={ node = "pitch" },
      value="/custom_properties/pitch"
    },
    jbox.analog_knob{
      graphics={ node = "length" },
      value="/custom_properties/length"
    },
    jbox.analog_knob{
      graphics={ node = "pan" },
      value="/custom_properties/pan"
    },
    jbox.analog_knob{
      graphics={ node = "amplitude" },
      value="/custom_properties/amplitude"
    },
    jbox.momentary_button{
      graphics = { node = "trigger" },
      value = "/custom_properties/trigger"
    },
    jbox.sequence_fader{
      graphics = { node = "triggerMode" },
      value = "/custom_properties/triggerMode"
    },
    jbox.sequence_meter{
      graphics = { node = "triggered" },
      value = "/custom_properties/triggered"
    },
    jbox.analog_knob{
      graphics{node="VCOFreq"},
      value="/custom_properties/vcoFrequency"
    },
    jbox.toggle_button{
      graphics = {node="VCOHold"},
      value="/custom_properties/vcoHold"
    },
    jbox.toggle_button{
      graphics = {node="VCOModOnOff"},
      value="/custom_properties/vcoModulatorActive"
    },
    jbox.analog_knob{
      graphics{node="VCOModMultiplier"},
      value="/custom_properties/vcoModulatorMultiplier"
    },
    
  }	
}
back = jbox.panel { 
  graphics = { node = "Bg" },
  widgets = {
    jbox.placeholder {
      graphics = { node = "Placeholder" },
    },
    jbox.cv_input_socket {
      graphics = { node = "TriggerIn" },
      socket = "/cv_inputs/externalTrigger",
    },
    jbox.audio_output_socket {
      graphics = { node = "AudioOutLeft" },
      socket = "/audio_outputs/audioOutLeft",
    },

    jbox.audio_output_socket {
      graphics = { node = "AudioOutRight" },
      socket = "/audio_outputs/audioOutRight",
    },
    jbox.device_name {
      graphics = { node = "deviceName" },
    }
  }
}

folded_front = jbox.panel { 
  graphics = { node = "Bg" },
  widgets = {}
}

folded_back = jbox.panel { 
  graphics = { node = "Bg" },
  cable_origin = { node = "CableOrigin" },
  widgets = {}
}
