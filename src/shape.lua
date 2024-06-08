local shape={
  x=0,
  y=0,
  width=0,
  height=0,
  radius=0,
  kind=nil
}

function shape:new(o)
  o=type(o)=='table' and o or {}
  local a={}
  setmetatable(a, self)
  self.__index=self
  a:setX(o.x)
  a:setY(o.y)
  for _,v in ipairs{'width', 'height', 'radius'} do
    if type(o[v])=='number' and o[v]>0 then
      a[v]=o[v]
    end
  end
  return a;
end

function shape:newRect(o)
  o=self:new(o)
  o.radius=0
  if o.width==0 or o.height==0 then
    o.kind=nil
    o.width=0
    o.height=0
  else
    o.kind='rect'
  end
  return o;
end

function shape:newCirc(o)
  o=self:new(o)
  o.width=0
  o.height=0
  if o.radius==0 then
    o.kind=nil
    o.radius=0
  else
    o.kind='circ'
  end
  return o;
end

function shape:getX()
  return self.x
end

function shape:setX(x)
  if type(x)=='number' and x>=0 then
    self.x=x
  end
  return self.x
end

function shape:getY()
  return self.y
end

function shape:setY(y)
  if type(y)=='number' and y>=0 then
    self.y=y
  end
  return self.y
end

function shape:getWidth()
  return self.width
end

function shape:setWidth(width)
  if self:isRect() and type(width)=='number' and width>0 then
    self.width=width
  end
  return self.width
end

function shape:getHeight()
  return self.height
end

function shape:setHeight(height)
  if self:isRect() and type(height)=='number' and height>0 then
    self.height=height
  end
  return self.height
end

function shape:getRadius()
  return self.radius
end

function shape:setRadius(radius)
  if self:isCirc() and type(radius)=='number' and radius>0 then
    self.radius=radius
  end
  return self.radius
end

function shape:isOver(x,y)
  assert(type(x)=='number' and x>=0, 'x must be a non negative number')
  assert(type(y)=='number' and y>=0, 'y must be a non negative number')
  if self:isRect() then
    return self.x<=x and x<=self.x+self.width and self.y<=y and y<=self.y+self.height
  elseif self:isCirc() then
    return (x-self.x)^2 + (y-self.y)^2 <= self.radius^2
  else
    return false
  end
end

function shape:isRect(val)
  return self.kind=='rect'
end

function shape:isCirc(val)
  return self.kind=='circ'
end

function shape:isNil(val)
  return self.kind==nil
end

return shape
