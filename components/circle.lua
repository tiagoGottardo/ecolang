local Circle = {}
Circle.__index = Circle

local t = require 'utils.input'

function Circle:new(circleTable)
  circleTable = circleTable or {}
  local instance = setmetatable({}, Circle)
  instance:set(circleTable)
  return instance
end

function Circle:set(circleTable)
  circleTable = circleTable or {}
  self.radius = t.sanitizeMin(circleTable.radius, 0) or self.radius or 0
end

function Circle:get()
  return { radius = self.radius }
end

function Circle:draw(R, G, B, A, X, Y)
  local r, g, b, a = love.graphics:getColor()
  love.graphics.setColor(R, G, B, A)
  love.graphics.circle("fill", X, Y, self.radius)
  love.graphics.setColor(r, g, b, a)
end

function Circle:debug()
  print("   Circle(Radius: " .. self.radius .. ")")
end

return Circle
