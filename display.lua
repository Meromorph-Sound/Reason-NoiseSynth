format_version = "1.0"

local Axes = { r=180,g=180,b=180 }
local Rect = { r=80,g=80,b=80,a = 64 }
local Graph = { r=0,g=255,b=0  }

function Clamp(value)
  return math.max(0,math.min(1,value))
end

function ValueOf(sampleRate,alpha,exponent,freq)
  return alpha*math.pow(sampleRate/freq,exponent)
end

function ChangeTable(freq,name)
  freq=Clamp(freq)
  jbox.trace("Setting freq = " .. freq .. "for function " .. name)
  
  local changes = {}
  changes[1] = freq
  
  return {
    gesture_ui_name = jbox.ui_text(name),
    property_changes = changes
  }
end


function drawTextBox(property_values,last_property_values,display_info)
  local lfoFreq=property_values[1]
  local w=display_info.width
  local h=display_info.height


end


function actionTextBox(property_values,display_info,gesture_start_point)
  local y=gesture_start_point.y;
  local f=property_values[1];

  local gestureDefinition = {
    custom_data = {
      freq = f,
      y = y
    },
    handlers = {
      on_tap = "DidTap",
      on_update = "DidMove",
      on_release = "DidMove",
      on_cancel = "DidReset"
    }
  }
  return gestureDefinition
end

function DidTap(property_values,display_info,gesture_info,custom_data)
  local f = property_values[1]
  local y = gesture_info.current_point.y
  assert(y ~= nil)
  assert(f ~= nil)

  custom_data = {
    freq = f,
    y = y
  }
  return ChangeTable(f,"DidTap")
end

function DidMove(property_values,display_info,gesture_info,custom_data) 

  local f = property_values[1]
  local lasty = custom_data.y
  assert(lasty ~= nil)
  assert(f ~= nil)

  local y = gesture_info.current_point.y
  if y-lasty > 2 then
    f=Clamp(f+0.01)
    custom_data.y=y
  elseif y-lasty < -2 then
    f=Clamp(f-0.01)
    custom_data.y=y
  end

  
  return ChangeTable(f,"DidMove")
end

function DidReset(property_values,display_info,gesture_info,custom_data)
  local freq = custom_data.freq
  assert(freq ~= nil)
  
  return ChangeTable(freq,"resetLFO")
end