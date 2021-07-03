format_version = "2.0"

local LightBlue = {26,130,196}
local White = {255,255,255}

front = jbox.panel { 
	graphics = {
		node = "Bg",
	},
	widgets = {
	jbox.device_name {
			graphics = { node = "deviceName" },
		},
  jbox.patch_browse_group { graphics = {node="patches"}},
  jbox.patch_name{
      graphics = { node = "patch" },
      fg_color = White,
      loader_alt_color = LightBlue,
      center = false,
      text_style = "Bold LCD font",
  },
	jbox.analog_knob{
	 graphics = { node = "alpha" },
	 value = "/custom_properties/alpha"
	},
  jbox.momentary_button{
    graphics = { node = "reload" },
    value = "/custom_properties/reload"
  },
  jbox.sequence_fader{
    graphics={node="seed"},
    value = "/custom_properties/seed",
    orientation = "horizontal",
    handle_size = 25
  },
    jbox.analog_knob{
      graphics={ node = "exponent" },
      value = "/custom_properties/exponent"
    },
    jbox.custom_display {
      graphics={ node="exponent_display" },
      display_width_pixels = 600,
      display_height_pixels = 245,
      values = {
        "/custom_properties/alpha",
        "/custom_properties/exponent"
        },
      draw_function = "drawExponent"
    },
    jbox.analog_knob{
   graphics = { node = "mutate" },
   value = "/custom_properties/mutate"
  },
    jbox.sequence_meter{
      graphics={node="note"},
      value = "/custom_properties/note"
    },
    jbox.custom_display {
      graphics={node="volume"},
      display_width_pixels=300,
      display_height_pixels=40,
      values = { "/custom_properties/volume" },
      draw_function = "drawVolume"
    },
    jbox.up_down_button{
    graphics={node="range"},
    value="/custom_properties/pitchBendRange"
    },
    jbox.analog_knob{
    graphics={ node = "rangeDisplay" },
    value="/custom_properties/pitchBendRange"
    },
    jbox.up_down_button{
    graphics={node="mutateRange"},
    value="/custom_properties/mutateRange"
    },
    jbox.analog_knob{
    graphics={ node = "mutateRangeDisplay" },
    value="/custom_properties/mutateRange"
    }
  }
	
}
back = jbox.panel { 
	graphics = {
		node = "Bg",
	},
	widgets = {
		jbox.placeholder {
			graphics = { node = "Placeholder" },
		},
	jbox.audio_output_socket {
			graphics = { node = "AudioLeft" },
			socket = "/audio_outputs/audioL",
		},

    jbox.audio_output_socket {
      graphics = { node = "AudioRight" },
      socket = "/audio_outputs/audioR",
    },
    jbox.device_name {
      graphics = { node = "deviceName" },
    },
	},
}
folded_front = jbox.panel { 
	graphics = {
		node = "Bg",
	},
	widgets = {
    jbox.device_name { graphics = { node = "deviceName" }},
  jbox.patch_browse_group { graphics = {node="patches"}},
  jbox.patch_name{
      graphics = { node = "patch" },
      fg_color = { 255,255,255 },
      loader_alt_color = LightBlue,
      center = false,
      text_style = "Bold LCD font"
  },
  jbox.sequence_meter{ graphics={node="note"}, value = "/custom_properties/note" },
  jbox.custom_display {
      graphics={node="volume"},
      display_width_pixels=300,
      display_height_pixels=40,
      values = { "/custom_properties/volume" },
      draw_function = "drawVolume"
    }
	}
}
folded_back = jbox.panel { 
	graphics = {
		node = "Bg",
	},
	cable_origin = {
		node = "CableOrigin",
	},
	widgets = {
	},
}
