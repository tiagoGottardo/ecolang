local Square = {}
Square.__index = Square

function Square:new(squareTable)
  squareTable = squareTable or {}
  local instance = setmetatable({}, Square)
  instance:set(squareTable)
  return instance
end

local function sanitizeValue(val, min)
  if type(min) ~= 'number' or type(val) ~= 'number' then
    return nil
  end

  return math.max(val, min)
end

function Square:set(squareTable)
  squareTable = squareTable or {}
  self.size = sanitizeValue(squareTable.width, 0) or self.size or 0
  self.radius = sanitizeValue(squareTable.radius, 0) or self.radius or 0
end

function Square:draw(R, G, B, A, position)
  local r, g, b, a = love.graphics:getColor()
  love.graphics.setColor(R, G, B, A)
  love.graphics:rectangle("fill", position[1], position[2], self.size, self.size, self.radius)
  love.graphics:setColor(r, g, b, a)
end

function Square:get()
  return { size = self.size, radius = self.radius }
end

function Square:debug()
  print("   Square(Size: " .. self.size .. ", Radius: " .. self.radius .. ")")
end

return Square
