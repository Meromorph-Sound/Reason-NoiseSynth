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

function labelType(tags)
  local items={}
  for _, value in pairs(tags) do
     table.insert(items,jbox.ui_text(value))
  end
  return jbox.ui_selector(items)
end  

function append(to,extras)
  for k,v in pairs(extras) do
    to[k]=v 
  end
  return to
end  




custom_properties = jbox.property_set{
  document_owner = {
    properties = {
    ["shape"] = jbox.number {
        default=0,
        steps=9,
        ui_name = jbox.ui_text("shape"),  
        property_tag=1,
        ui_type = rangeType(9) 
      },
     ["pitch"] = jbox.number {
      default=0,
      ui_name = jbox.ui_text("pitch"),  
      property_tag=2,
      ui_type = jbox.ui_linear{
        min = 100,
        max = 10000,
        units = {{ decimals=1, unit = { template = jbox.ui_text("hertz") }}}
      }
    },
     ["length"] = jbox.number {
      default=0,
      ui_name = jbox.ui_text("length"),  
      property_tag=3,
      ui_type = jbox.ui_linear{
        min=0,
        max=500,
        units = {{ decimals=0}}
      }
     },
     ["pan"] = jbox.number {
      default=0.5,
      ui_name = jbox.ui_text("pan"),  
      property_tag=4,
      ui_type = jbox.ui_linear{
        min = -90,
        max = 90,
        units = {
          min_text=jbox.ui_text("left"),
          max_text=jbox.ui_text("right"),
          { 
            decimals=2,
            unit={ template = jbox.ui_text("degrees") }
          }
        }
      }
     },
     ["amplitude"] = jbox.number {
      default=1,
      ui_name = jbox.ui_text("amplitude"),  
      property_tag=5,
      ui_type = jbox.ui_percent{decimals=1}
     },
     ["trigger"] = jbox.number {
        default=0,
        steps=2,
        ui_name = jbox.ui_text("trigger"),  
        property_tag=6,
        ui_type = jbox.ui_selector({jbox.UI_TEXT_OFF,jbox.UI_TEXT_ON})
      },
      ["triggerMode"] = jbox.number {
        default=0,
        steps=3,
        ui_name = jbox.ui_text("trigger"),  
        property_tag=7,
        ui_type = labelType({"external","clocked","manual"})
      },
    }
	},
	rtc_owner = {
		properties = { instance = jbox.native_object{} }
	},
	rt_owner = {
		properties = {
		  triggered = jbox.number {
		    default = 0,
        steps = 2,
        ui_name = jbox.ui_text("trigger"),
        property_tag = 10,
        ui_type = jbox.ui_selector{ jbox.UI_TEXT_OFF, jbox.UI_TEXT_ON } 
		  }
		}
	}
}

midi_implementation_chart = {
	midi_cc_chart = {
--   [13] = "/custom_properties/trigger",                -- ControlEffectControl2
--	 [16] = "/custom_properties/shape",               -- ControlGeneralPurpose1
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
--  ["/custom_properties/triggerMode"] = remote("triggerMode"),
 -- ["/custom_properties/trigger"] = remote("trigger"),
 -- ["/custom_properties/shape"] = remote("shape"),
}

ui_groups = {}

cv_inputs = {
  externalTrigger = jbox.cv_input{ ui_name = jbox.ui_text("trigger") }
}
cv_outputs = {}

audio_inputs = {}
audio_outputs = {
	audioOutLeft = jbox.audio_output{ ui_name = jbox.ui_text("audioOutput") },
	audioOutRight = jbox.audio_output{ ui_name = jbox.ui_text("audioOutput") }
}













