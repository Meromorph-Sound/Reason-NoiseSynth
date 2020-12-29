format_version = "2.0"
front = jbox.panel { 
	graphics = {
		node = "Bg",
	},
	widgets = {
	jbox.device_name {
			graphics = { node = "deviceName" },
		},
	jbox.analog_knob{
	 graphics = { node = "alpha" },
	 value = "/custom_properties/alpha"
	},
  jbox.momentary_button{
    graphics = { node = "reload" },
    value = "/custom_properties/reload"
  },
    jbox.analog_knob{
      graphics={ node = "exponent" },
      value = "/custom_properties/exponent"
    },
    jbox.custom_display {
      graphics={ node="exponent_display" },
      display_width_pixels = 600,
      display_height_pixels = 300,
      values = {
        "/custom_properties/alpha",
        "/custom_properties/exponent"
        },
      draw_function = "drawExponent"
    },
    jbox.sequence_meter{
      graphics={note="note"},
      value = "/custom_properties/note"
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
	},
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
