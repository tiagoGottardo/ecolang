local shape = {
  x = 0,
  y = 0,
  color = { 0, 0, 0, 0 },
  width = 0,
  height = 0,
  radius = 0,
  kind = nil
}

function shape:new(o)
  o = type(o) == 'table' and o or {}
  local a = {}
  setmetatable(a, self)
  self.__index = self
  a:setRadius(o.radius)
  a:setSize({ o.width, o.height })
  a:setPosition({ o.x, o.y })
  return a;
end

function shape:newRect(o)
  o = self:new(o)
  o.radius = 0
  if o.width == 0 or o.height == 0 then
    o.kind = nil
    o.width = 0
    o.height = 0
  else
    o.kind = 'rect'
  end
  return o;
end

function shape:newCirc(o)
  o = self:new(o)
  o.width = 0
  o.height = 0
  if o.radius == 0 then
    o.kind = nil
    o.radius = 0
  else
    o.kind = 'circ'
  end
  return o;
end

function shape:getX()
  return self.x
end

function shape:setX(x)
  if type(x) == 'number' and x >= 0 then
    self.x = x
  else
    self.x = 0
  end
  return self.x
end

function shape:getY()
  return self.y
end

function shape:setY(y)
  if type(y) == 'number' and y >= 0 then
    self.y = y
  else
    self.y = 0
  end
  return self.y
end

function shape:getWidth()
  return self.width
end

function shape:setWidth(width)
  if type(width) == 'number' and width > 0 then
    self.width = width
  end
  return self.width
end

function shape:getHeight()
  return self.height
end

function shape:setHeight(height)
  if type(height) == 'number' and height > 0 then
    self.height = height
  end
  return self.height
end

function shape:getRadius()
  return self.radius
end

function shape:setRadius(radius)
  if self:isCirc() and type(radius) == 'number' and radius > 0 then
    self.radius = radius
  end
  return self.radius
end

function shape:isOver(x, y)
  assert(type(x) == 'number' and x >= 0, 'x must be a non negative number')
  assert(type(y) == 'number' and y >= 0, 'y must be a non negative number')
  if self:isRect() then
    return self.x <= x and x <= self.x + self.width and self.y <= y and y <= self.y + self.height
  elseif self:isCirc() then
    return (x - self.x) ^ 2 + (y - self.y) ^ 2 <= self.radius ^ 2
  else
    return false
  end
end

local function scale(scalar, total)
  return scalar / 100 * total
end

function shape:setSize(size, ref)
  if type(size[1]) ~= 'number' or type(size[2]) ~= 'number' then
    self.width, self.height = 0, 0
    return
  end
  if type(ref) == 'nil' then
    self:setWidth(scale(size[1], love.graphics.getWidth()))
    self:setHeight(scale(size[2], love.graphics.getHeight()))
  else
    self:setWidth(scale(size[1], ref:getHeight()))
    self:setHeight(scale(size[2], ref:getWidth()))
  end
end

function shape:setPosition(coordinates, ref)
  if type(coordinates[1]) ~= 'number' or type(coordinates[2]) ~= 'number' then
    self.x, self.y = 0, 0;
    return
  end
  if type(ref) == 'nil' then
    self:setX(scale(coordinates[1], love.graphics.getWidth()) - self.width / 2)
    self:setY(scale(coordinates[2], love.graphics.getHeight()) - self.height / 2)
  else
    self:setX(ref.x + scale(coordinates[1], ref:getWidth()) - self.width / 2)
    self:setY(ref.y + scale(coordinates[2], ref:getHeight()) - self.height / 2)
  end
end

function shape:getColor()
  local resultColor = {}
  for i = 1, 3 do
    resultColor[i] = self.color[i] * 255
  end
  resultColor[4] = self.color[4] * 100

  return resultColor
end

function shape:setColor(color)
  if type(color) == 'table' then
    color[3] = type(color[3]) == 'number' and color[3] or 1
    local scaledColor = {}
    for i = 1, 3 do
      scaledColor[i] = color[i] / 255
      color[i] = type(color[i]) == 'number' and math.max(math.min(scaledColor[i], 1), 0) or 0
    end
    self.color[4] = color[4] / 100
    self.color = color
  end

  return self.color
end

function shape:draw(love)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)
  if self:isRect() then
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  elseif self:isCirc() then
    love.graphics.circle("fill", self.x, self.y, self.radius)
  end
  love.graphics.setColor(r, g, b, a)
end

function shape:isRect()
  return self.kind == 'rect'
end

function shape:isCirc()
  return self.kind == 'circ'
end

function shape:isNil()
  return self.kind == nil
end

return shape
