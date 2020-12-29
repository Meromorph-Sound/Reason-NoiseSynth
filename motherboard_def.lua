format_version = "3.0"


function linearType()
  return jbox.ui_linear {
    min=0,
    max=1,
    units = {
      min_text = jbox.ui_text("zero"),
      max_text = jbox.ui_text("one"),
      { 
        decimals=2,
        unit = { template = jbox.ui_text("linear_template") }
      }
    }
  }
end

function panType()
  return jbox.ui_nonlinear {
    data_to_gui = function(value) 
      return 90*(2*value-1)
    end,
    gui_to_data = function(value)
      return ((value/90)+1)*0.5
    end,
    units = {
      { 
        decimals=2,
        unit = { template = jbox.ui_text("linear_template") }
      }
    }
  }
end

custom_properties = jbox.property_set{
	document_owner = {
		properties = {
		  alpha = jbox.number {
		    default = 0,
		    ui_name = jbox.ui_text("alpha"),
		    property_tag = 1,
		    ui_type = linearType()
		  },
		  reload = jbox.number {
        default=0,
        steps=2,
        ui_name = jbox.ui_text("reload"),	
        property_tag=2,
        ui_type = jbox.ui_selector{ jbox.UI_TEXT_OFF, jbox.UI_TEXT_ON }	  
		  },
		  pan = jbox.number {
        default = 0.5,
        ui_name = jbox.ui_text("gain"),
        property_tag = 3,
        ui_type = gainType()
      },
      exponent = jbox.number {
        default=0.5,
        ui_name = jbox.ui_text("exponent"),
        property_tag = 4,
        ui_type = linearType()
      },
		  pitchBend = jbox.performance_pitchbend {
		    ui_name = jbox.ui_text("pitchbend"),
		    property_tag = 10,
		  }
		}
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













