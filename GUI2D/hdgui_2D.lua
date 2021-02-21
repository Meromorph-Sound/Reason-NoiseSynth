format_version = "2.0"

local LightBlue = {26,130,196}
local White = {255,255,255}

function text_display(node,property)
  return jbox.value_display{
      graphics = { ["node"] = node },
      value = "/custom_properties/"..property,
      text_color = White,
      text_style = "Small label font",
  }
end

front = jbox.panel { 
  graphics = { node = "Bg" },
  widgets = {
    jbox.device_name { graphics = {node = "deviceName" }},
    jbox.patch_browse_group { graphics = {node="patches"}},
    jbox.patch_name{
      graphics = { node = "patch" },
      fg_color = { 255,255,255 },
      loader_alt_color = LightBlue,
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
    text_display("pitchDisplay","pitch"),
    jbox.analog_knob{
      graphics={ node = "length" },
      value="/custom_properties/length"
    },
    text_display("lengthDisplay","length"),
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
      graphics = {node="limiter"},
      value="/custom_properties/limiter"
    },
    jbox.toggle_button{
      graphics = {node="limiterOnOff"},
      value="/custom_properties/limiterOnOff"
    },
    jbox.toggle_button{
      graphics = {node="limiterHardSoft"},
      value="/custom_properties/limiterHardSoft"
    },
    text_display("limiterDisplay","limiter"),
    
    jbox.analog_knob{
      graphics = {node="VCOFreq"},
      value="/custom_properties/vcoFrequency"
    },
    text_display("lfoFreqDisplay","vcoFrequency"),
    jbox.toggle_button{
      graphics = {node="VCOHold"},
      value="/custom_properties/vcoHold"
    },
    jbox.toggle_button{
      graphics = {node="VCOModOnOff"},
      value="/custom_properties/vcoModulatorActive"
    }
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
    jbox.cv_input_socket {
      graphics = { node = "LFOModulatorIn" },
      socket = "/cv_inputs/lfoModulator",
    },
    jbox.cv_trim_knob{
      graphics = { node = "LFOModulatorTrim" },
      socket = "/cv_inputs/lfoModulator",
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
