local Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:new(rectangleTable)
  rectangleTable = rectangleTable or {}
  local instance = setmetatable({}, Rectangle)
  instance:set(rectangleTable)
  return instance
end

local function sanitizeValue(val, min)
  if type(min) ~= 'number' or type(val) ~= 'number' then
    return nil
  end

  return math.max(val, min)
end

function Rectangle:set(rectangleTable)
  rectangleTable = rectangleTable or {}
  self.width = sanitizeValue(rectangleTable.width, 0) or self.width or 0
  self.height = sanitizeValue(rectangleTable.height, 0) or self.height or 0
  self.radius = sanitizeValue(rectangleTable.radius, 0) or self.radius or 0
end

function Rectangle:draw(R, G, B, A, X, Y)
  local r, g, b, a = love.graphics.getColor() -- Previous system color
  love.graphics.setColor(R, G, B, A)
  love.graphics.rectangle("fill", X, Y, self.width, self.height, self.radius)
  love.graphics.setColor(r, g, b, a)
end

function Rectangle:get()
  return { width = self.width, height = self.height, radius = self.radius }
end

function Rectangle:debug()
  print("   Rectangle(Size: " .. self.width .. "x" .. self.height .. ", Radius: " .. self.radius .. ")")
end

return Rectangle
