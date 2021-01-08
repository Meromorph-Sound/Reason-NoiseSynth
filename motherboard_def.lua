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

function rangeType(n)
  return jbox.ui_linear {
    min=0,
    max=n-1,
    units = {
      min_text = jbox.ui_text("linear_template"),
      max_text = jbox.ui_text("linear_template"),
      { 
        decimals=0,
        unit = { template = jbox.ui_text("linear_template") }
      }
    }
  }
end

function seedType()
  return jbox.ui_nonlinear {
    data_to_gui = function(value) 
      return value+1
    end,
    gui_to_data = function(value)
      return value-1
    end,
    units = {
      { 
        decimals=0,
        unit = { template = jbox.ui_text("linear_template") }
      }
    }
  }
end

function bendRangeType()
  return jbox.ui_nonlinear {
    data_to_gui = function(value) 
      return value+1
    end,
    gui_to_data = function(value)
      return value-1
    end,
    units = {
      { 
        decimals=0,
        unit = { template = jbox.ui_text("linear_template") }
      }
    }
  }
end

local mutateValues = {5,10,25,50,75,100}

function mutateRangeType() 
  return jbox.ui_nonlinear {
    data_to_gui = function(value) 
      return mutateValues[value+1]
    end,
    gui_to_data = function(value)
      for k, v in pairs(mutateValues) do
        if v==value then
          return k-1
        end
      end
      return 0
    end,
    units = {
      { 
        decimals=0,
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
		  seed = jbox.number {
        default=13,
        steps=25,
        ui_name = jbox.ui_text("seed"),
        property_tag = 3,
        ui_type = seedType()
      },
      exponent = jbox.number {
        default=0.5,
        ui_name = jbox.ui_text("exponent"),
        property_tag = 4,
        ui_type = linearType()
      },
      mutate = jbox.number {
        default = 0,
        ui_name = jbox.ui_text("mutate"),
        property_tag = 7,
        ui_type = linearType()
      },
      mutateRange = jbox.number {
        default = 2,
        steps = 6,
        ui_name=jbox.ui_text("mutateRange"),
        property_tag=8,
        ui_type = mutateRangeType()
      },
      pitchBendRange = jbox.number {
        default=11,
        steps=24,
        ui_name=jbox.ui_text("range"),
        property_tag = 9,
        ui_type = bendRangeType()
      },
		  pitchBend = jbox.performance_pitchbend {
		    ui_name = jbox.ui_text("pitchbend"),
		    property_tag = 10,
		  },
		  expression = jbox.performance_expression {
		    ui_name = jbox.ui_text("expression"),
		    property_tag=11  
		  }
		}
	},
	rtc_owner = {
		properties = { instance = jbox.native_object{} }
	},
	rt_owner = {
		properties = {
		  note = jbox.number {
		    default=0,
		    steps=2,
		    ui_name=jbox.ui_text("note"),
		    property_tag=5,
		    ui_type = jbox.ui_selector{ jbox.UI_TEXT_OFF, jbox.UI_TEXT_ON }
		  },
		  volume = jbox.number {
        default=0,
        ui_name=jbox.ui_text("volume"),
        property_tag=6,
        ui_type = linearType()
      }
		},
		
	}
}

midi_implementation_chart = {
	midi_cc_chart = {
	 [12] = "/custom_properties/reload",              -- ControlEffectControl1
   [13] = "/custom_properties/seed",                -- ControlEffectControl2
	 [16] = "/custom_properties/alpha",               -- ControlGeneralPurpose1
	 [17] = "/custom_properties/exponent",            -- ControlGeneralPurpose2
	 [18] = "/custom_properties/pitchBendRange",      -- ControlGeneralPurpose3
	 [19] = "/custom_properties/mutate",              -- ControlGeneralPurpose3
	 [20] = "/custom_properties/mutateRange",         -- ControlGeneralPurpose3
	}
}

function remote(name) 
return {
  internal_name = name,
  short_ui_name = jbox.ui_text(name.."_short"),
  shortest_ui_name = jbox.ui_text(name.."_shortest")
}
end

remote_implementation_chart = {
  ["/custom_properties/reload"] = remote("reload"),
  ["/custom_properties/seed"] = remote("seed"),
  ["/custom_properties/alpha"] = remote("alpha"),
  ["/custom_properties/exponent"] = remote("exponent"),
  ["/custom_properties/pitchBendRange"] = remote("range"),
  ["/custom_properties/mutate"] = remote("mutate"),
  ["/custom_properties/mutateRange"] = remote("mutateRange")
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













