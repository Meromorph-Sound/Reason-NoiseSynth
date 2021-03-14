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

local shapeNames = { 
  "normal", 
  "poisson", 
  "triangleDown", 
  "triangleUp", 
  "triangle", 
  "delta", 
  "expHard", 
  "expSoft", 
  "square" 
}

local uiShapeNames={}
for _,name in pairs(shapeNames) do
  table.insert(uiShapeNames,jbox.ui_text(name))
end 

-- Some range properties
PITCH_MIN = 20
PITCH_MAX = 10000

LENGTH_MIN = 1
LENGTH_MAX = 500

LIMITER_MIN = -12
LIMITER_MAX = 0

-- The property tags
local SHAPE_TAG = 1
local PITCH_TAG = 2
local LENGTH_TAG = 3
local PAN_TAG = 4
local AMPLITUDE_TAG = 5
local TRIGGER_TAG = 6
local TRIGGER_MODE_TAG = 7
local LIMITER_TAG = 8
local LIMITER_ONOFF_TAG = 9
local LIMITER_HARD_SOFT_TAG = 10

local LFO_FREQUENCY_TAG = 11
local LFO_HOLD_TAG = 12
local LFO_MODULATOR_ONOFF_TAG = 13

local EXT_TRIGGER_THRESHOLD_TAG = 14
local EXT_TRIGGER_DEBOUNCE_TAG = 15

local TRIGGERED_TAG = 20

local Props = {
 
  PropertiesTable = {
    [SHAPE_TAG] = "shape",
    [PITCH_TAG] = "pitch",
    [LENGTH_TAG] = "length",
    [PAN_TAG] = "pan",
    [AMPLITUDE_TAG] = "amplitude",
    [TRIGGER_TAG] = "trigger",
    [TRIGGER_MODE_TAG] = "triggerMode",
    [LIMITER_TAG] = "limiter",
    [LIMITER_ONOFF_TAG] = "limiterOnOff",
    [LIMITER_HARD_SOFT_TAG] = "limiterHardSoft",
    [LFO_FREQUENCY_TAG] = "vcoFrequency",
    [LFO_HOLD_TAG] = "vcoHold",
    [LFO_MODULATOR_ONOFF_TAG] = "vcoModulatorActive",
    [EXT_TRIGGER_THRESHOLD_TAG] = "externalTriggerThreshold",
    [EXT_TRIGGER_DEBOUNCE_TAG] = "externalTriggerDebounce"
  },
  
  
  name = function(tag) return Props.PropertiesTable[tag] end,
  path = function(tag) return "/custom_properties" .. Props.name(tag) end
}




custom_properties = jbox.property_set{
  document_owner = {
    properties = {
    ["shape"] = jbox.number {
        default=0,
        steps=9,
        ui_name = jbox.ui_text("shape"),  
        property_tag=SHAPE_TAG,
        ui_type = jbox.ui_selector(uiShapeNames)
      },
     ["pitch"] = jbox.number {
      default=20,
      steps = 10001,
      ui_name = jbox.ui_text("pitch"),  
      property_tag=PITCH_TAG,
      ui_type = jbox.ui_linear{
        min = 0,
        max = 10000,
        units = {{ decimals=0, unit = { template = jbox.ui_text("hertz") }}}
      }
    },
     ["length"] = jbox.number {
      default=100,
      steps=500,
      ui_name = jbox.ui_text("length"),  
      property_tag=LENGTH_TAG,
        ui_type = jbox.ui_linear{
          min=LENGTH_MIN,
          max=LENGTH_MAX,
          units = {{ decimals=0, unit = { template = jbox.ui_text("samples" )}}}
        }
     },
     ["pan"] = jbox.number {
      default=0.5,
      ui_name = jbox.ui_text("pan"),  
      property_tag=PAN_TAG,
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
      property_tag=AMPLITUDE_TAG,
      ui_type = jbox.ui_percent{decimals=1}
     },
     ["trigger"] = jbox.number {
        default=0,
        steps=2,
        ui_name = jbox.ui_text("trigger"),  
        property_tag=TRIGGER_TAG,
        ui_type = jbox.ui_selector({jbox.UI_TEXT_OFF,jbox.UI_TEXT_ON})
      },
      ["triggerMode"] = jbox.number {
        default=0,
        steps=3,
        ui_name = jbox.ui_text("trigger"),  
        property_tag=TRIGGER_MODE_TAG,
        ui_type = labelType({"external","clocked","manual"})
      },
      ["externalTriggerThreshold"] = jbox.number {
        default=0.5,
        ui_name=jbox.ui_text("extTriggerThreshold"),
        property_tag = EXT_TRIGGER_THRESHOLD_TAG,
        ui_type = jbox.ui_percent{decimals=2}
      },
      ["externalTriggerDebounce"] = jbox.number {
        default=1,
        steps=64,
        ui_name=jbox.ui_text("extTriggerDebounce"),
        property_tag = EXT_TRIGGER_DEBOUNCE_TAG,
        ui_type = jbox.ui_linear{
          min=0,
          max=63,
          units = {{ decimals=0, unit = { template = jbox.ui_text("samples" )}}}
        }
      },
      ["limiter"] = jbox.number {
      default=1,
      ui_name = jbox.ui_text("limiter"),  
      property_tag=LIMITER_TAG,
      ui_type = jbox.ui_linear{
          min=LIMITER_MIN,
          max=LIMITER_MAX,
          units = {{ decimals=1, unit = { template = jbox.ui_text("decibels" )}}}
        }
     },
     ["limiterOnOff"] = jbox.number {
        default=1,
        steps=2,
        ui_name = jbox.ui_text("limiter"),  
        property_tag=LIMITER_ONOFF_TAG,
        ui_type = jbox.ui_selector({jbox.UI_TEXT_OFF,jbox.UI_TEXT_ON})
      },
      ["limiterHardSoft"] = jbox.number {
        default=0,
        steps=2,
        ui_name = jbox.ui_text("limiter"),  
        property_tag=LIMITER_HARD_SOFT_TAG,
        ui_type = jbox.ui_selector({jbox.UI_TEXT_OFF,jbox.UI_TEXT_ON})
      },
      
      ["vcoFrequency"] = jbox.number {
        default=1,
        steps=7501,
        ui_name = jbox.ui_text("frequency"),
        property_tag = LFO_FREQUENCY_TAG,
        ui_type = jbox.ui_linear{
        min = 0,
        max = 750,
        units = {
          { 
            decimals=1,
            unit={ template = jbox.ui_text("hertz") }
          }
        }
      }},
      ["vcoHold"] =jbox.number {
        default=0,
        steps=2,
        ui_name = jbox.ui_text("hold"),  
        property_tag=LFO_HOLD_TAG,
        ui_type = jbox.ui_selector({jbox.UI_TEXT_OFF,jbox.UI_TEXT_ON})   
      }
	}},
	rtc_owner = {
		properties = { 
		instance = jbox.native_object{},
		extEnabled = jbox.boolean { 
		  default = false, 
		  ui_name = jbox.ui_text("trigger"),
		  ui_type = jbox.ui_selector({jbox.UI_TEXT_OFF,jbox.UI_TEXT_ON})
		}
	}
	},
	rt_owner = {
		properties = {
		  triggered = jbox.number {
		    default = 0,
        steps = 2,
        ui_name = jbox.ui_text("trigger"),
        property_tag = TRIGGERED_TAG,
        ui_type = jbox.ui_selector{ jbox.UI_TEXT_OFF, jbox.UI_TEXT_ON } 
		  }
		}
	}
}

local midi_cc = {}
for tag, name in pairs(Props.PropertiesTable) do
  midi_cc[101+tag] = "/custom_properties/"..name
end

midi_implementation_chart = {
	midi_cc_chart = {} -- midi_cc
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



jbox.add_stereo_instrument_routing_hint{
  left_output = "/audio_outputs/audioOutLeft",
  right_output = "/audio_outputs/audioOutRight",
}
jbox.add_stereo_audio_routing_target{
  signal_type = "send",
  left = "/audio_outputs/audioOutLeft",
  right = "/audio_outputs/audioOutRight",
  auto_route_enable = true
}

jbox.add_stereo_audio_routing_pair{
  left = "/audio_outputs/audioOutLeft",
  right = "/audio_outputs/audioOutRight"
}
















