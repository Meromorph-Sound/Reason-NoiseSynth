format_version = "1.0"

local Axes = { r=180,g=180,b=180 }
local Rect = { r=80,g=80,b=80,a = 64 }
local Graph = { r=0,g=255,b=0  }

function clip(value)
  return math.max(0,math.min(1,value))
end

function valueOf(sampleRate,alpha,exponent,freq)
  return alpha*math.pow(sampleRate/freq,exponent)
end


function drawExponent(property_values,display_info,dirty_rect)
  local alpha = clip(property_values[1])
  local exponent = clip(property_values[2])
  local rate = 100
  
  local w = display_info.width
  local h = display_info.height
  
  local fMin = 1
  local fMax = rate/2
  local xScale = (fMax-fMin)/w
  
  if alpha>0 then
  
    
    local yMax = valueOf(rate,1,exponent,fMin)
    local yMin = 0
    local yScale = (yMax-yMin)/h;
    jbox.trace("yMax ="..yMax)
   
    local points={}
    jbox.trace("Rate ="..rate)
    jbox.trace("Alpha ="..alpha)
    jbox.trace("Exponent ="..exponent)
    
    -- lines
    local yAlpha = h*valueOf(rate,alpha,0,fMin)
    jbox_display.draw_rect({left= 0, top= h-yAlpha, right= w-1, bottom= h-1},Rect)
    
    for x = 0,w,5 do
      local freq=fMin+xScale*x
      local y=valueOf(rate,alpha,exponent,freq)/yScale
      --jbox.trace("x="..x.." freq="..freq.." y="..y)
      table.insert(points,{x=x,y=h-y})
    end
    table.insert(points,{x=w,y=h})
    table.insert(points,{x=0,y=h})
    jbox_display.draw_polygon(points,Graph)
    
    
    
  end
  
   -- axes
  jbox_display.draw_lines({ {x=0,y=0},{x=w-1,y=0},{x=w-1,y=h-1},{x=0,y=h-1} },Axes,"closed") 
end

function drawVolume(property_values,display_info,dirty_rect)
  local volume=clip(property_values[1])
  local w = display_info.width
  local h = display_info.height
  
  local width = w*volume
  jbox_display.draw_rect({left= 0, top= 0, right= width, bottom= h-1},Graph)
  
end
