format_version = "3.0"



custom_properties = jbox.property_set{
	document_owner = {
		properties = {}
	},
	rtc_owner = {
		properties = { instance = jbox.native_object{} }
	},
	rt_owner = {
		properties = {
		
		},
		
	}
}

midi_implementation_chart = {
	midi_cc_chart = {}
}

remote_implementation_chart = {
}

ui_groups = {}

cv_inputs = {}
cv_outputs = {}

audio_inputs = {}
audio_outputs = {
	audioL = jbox.audio_output{ ui_name = jbox.ui_text("audioOutput") },
	audioR = jbox.audio_output{ ui_name = jbox.ui_text("audioOutput") }
}


jbox.add_stereo_instrument_routing_hint{
  left_output = "/audio_outputs/audioL",
  right_output = "/audio_outputs/audioR",
}
jbox.add_stereo_audio_routing_target{
  signal_type = "send",
  left = "/audio_outputs/audioL",
  right = "/audio_outputs/audioR",
  auto_route_enable = true
}

jbox.add_stereo_audio_routing_pair{
  left = "/audio_outputs/audioL",
  right = "/audio_outputs/audioR"
}













