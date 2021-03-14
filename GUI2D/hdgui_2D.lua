format_version = "2.0"

local LightBlue = {26,130,196}
local White = {255,255,255}

function text_display(node,property,tooltip)
  tooltip = tooltip or "simple"
  return jbox.value_display{
      graphics = { ["node"] = node },
      value = "/custom_properties/"..property,
      text_color = White,
      text_style = "Small label font",
      horizontal_justification = "left",
      tooltip_template = jbox.ui_text(tooltip)
  }
end

function special_display(node,property,tooltip)
  tooltip = tooltip or "simple"
  return jbox.value_display{
      graphics = { ["node"] = node },
      display_width_pixels=295,
      display_height_pixels=55,
      values = { "/custom_properties/"..property },
--    invalidate_function="invalidTextBox",
      draw_function="drawTextBox",
      gesture_function="actionTextBox"
  }
end

function prop_display(node,property)
  property = property or node
  return {
    graphics = { ["node"] = node },
      value = "/custom_properties/"..property,
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
    jbox.up_down_button(prop_display("shapeUpDown","shape")),
    jbox.analog_knob(prop_display("shape","shape")),
    text_display("pitchDisplay","pitch"),
    
    text_display("lengthDisplay","length"),
    jbox.analog_knob(prop_display("pan")),
    jbox.analog_knob(prop_display("amplitude")),
    
    jbox.momentary_button(prop_display("trigger")),
    jbox.sequence_fader(prop_display("triggerMode")),
    jbox.sequence_meter(prop_display("triggered")),
    
    jbox.toggle_button(prop_display("limiterOnOff")),
    jbox.toggle_button(prop_display("limiterHardSoft")),
    text_display("limiterDisplay","limiter"),
    text_display("lfoFreqDisplay","vcoFrequency"),
    jbox.toggle_button(prop_display("VCOHold","vcoHold")),
    
    text_display("threshold","externalTriggerThreshold"),
    text_display("delay","externalTriggerDebounce"),
  }	
}
back = jbox.panel { 
  graphics = { node = "Bg" },
  widgets = {
    jbox.placeholder { graphics = { node = "Placeholder" }},
    jbox.cv_input_socket { graphics = { node = "TriggerIn" }, socket = "/cv_inputs/externalTrigger"},
    jbox.audio_output_socket {graphics = { node = "AudioOutLeft" },socket = "/audio_outputs/audioOutLeft"},
    jbox.audio_output_socket {graphics = { node = "AudioOutRight" },socket = "/audio_outputs/audioOutRight"},
    jbox.device_name {graphics = { node = "deviceName" }},
--    jbox.sequence_meter{
--      graphics = { node = "enabled" },
--      value = "/custom_properties/extEnabled"
--    },
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
