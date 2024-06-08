local shape=require 'src.shape'
local Button={
  x=0,
  y=0,
  width=1,
  height=1,
  radius=0.5,
  color={255, 255, 255, 1},
  isPressed=false,
  state={},
  onLoad=function(self) return nil; end,
  onPress=function(self, mouse) return nil; end,
  onRelease=function(self, mouse) return nil; end,
}

function Button.isButton(val)
  return getmetatable(val)==Button
end

function Button:new(o)
  o = o or {}
  local a={}
  setmetatable(a, self)
  self.__index = self
  a:setX(o.x)
  a:setY(o.y)
  a:setWidth(o.width)
  a:setHeight(o.height)
  a:setRadius(o.radius)
  a:setColor(o.color)
  a:setState(o.state)
  a:setOnLoad(o.onLoad)
  a:setOnPress(o.onPress)
  a:setOnRelease(o.onRelease)
  return a
end

function Button:getX()
  return self.x
end

function Button:setX(x)
  if type(x)=='number' and x>=0 then
    self.x=x
  end
  return self.x
end

function Button:getY()
  return self.y
end

function Button:setY(y)
  if type(y)=='number' and y>=0 then
    self.y=y
  end
  return self.y
end

function Button:getWidth()
  return self.width
end

function Button:setWidth(width)
  if type(width)=='number' and width>0 then
    self.width=width
  end
  return self.width
end

function Button:getHeight()
  return self.height
end

function Button:setHeight(height)
  if type(height)=='number' and height>0 then
    self.height=height
  end
  return self.height
end

function Button:getRadius()
  return self.radius
end

function Button:setRadius(radius)
  if type(radius)=='number' and 2*radius<=math.min(self.width,self.height) then
    self.radius=radius
  end
  return self.radius
end

function Button:getColor()
  return self.color
end

function Button:setColor(color)
  if type(color)=='table' then
    color[4]=type(color[4])=='number' and color[4] or 1
    for i=1,4 do
      color[i]=type(color[i])=='number' and math.max(math.min(color[i], 1), 0) or 0
    end
    self.color=color
  end

  return self.color
end

function Button:getState()
  return self.state
end

function Button:setState(state)
  self.state=state
  return self.state
end

function Button:setOnLoad(fn)
  if type(fn)=='function' then
    self.onLoad=fn
  end
  return self.onLoad
end

function Button:setOnPress(fn)
  if type(fn)=='function' then
    self.onPress=fn
  end
  return self.onPress
end

function Button:setOnRelease(fn)
  if type(fn)=='function' then
    self.onRelease=fn
  end
  return self.onRelease
end

function Button:getShapes()
  local shapes={}
  if self.radius==0 then
    table.insert(shapes, shape:newRect{x=self.x, y=self.y, width=self.width, height=self.height})
  else
    if 2*self.radius<self.width then
      table.insert(shapes, shape:newRect{x=self.x+self.radius, y=self.y, width=self.width-2*self.radius, height=self.height})
      table.insert(shapes, shape:newCirc{x=self.x+self.radius, y=self.y+self.radius, radius=self.radius})
      table.insert(shapes, shape:newCirc{x=self.x+self.width-self.radius, y=self.y+self.radius, radius=self.radius})
    end
    if 2*self.radius<self.height then
      table.insert(shapes, shape:newRect{x=self.x, y=self.y+self.radius, width=self.width, height=self.height-2*self.radius})
      table.insert(shapes, shape:newCirc{x=self.x+self.radius, y=self.y+self.height-self.radius, radius=self.radius})
      table.insert(shapes, shape:newCirc{x=self.x+self.width-self.radius, y=self.y+self.height-self.radius, radius=self.radius})
    end
  end
  return shapes
end

function Button:isOver(x,y)
  local shapes=self:getShapes()
  for _,v in pairs(shapes) do
    if v:isOver(x,y) then
      return true
    end
  end
  return false
end

function Button:draw(love)
    love.graphics.setColor(self:getColor())
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.radius, self.radius)
end

return Button
