local Color = {}
Color.__index = Color

function Color:new(colorTable)
  colorTable = colorTable or {}
  local instance = setmetatable({}, Color)
  instance:set(colorTable)
  return instance
end

local function sanitizeValue(val, min, max)
  if type(val) ~= 'number' then
    return nil
  end

  return math.max(math.min(val, max), min)
end

function Color:set(colorTable)
  colorTable = colorTable or {}
  self.r = sanitizeValue(colorTable[1], 0, 255) or self.r or 255
  self.g = sanitizeValue(colorTable[2], 0, 255) or self.g or 255
  self.b = sanitizeValue(colorTable[3], 0, 255) or self.b or 255
  self.a = sanitizeValue(colorTable[4], 0, 1) or self.a or 1
end

function Color:get()
  return { self.r, self.g, self.b, self.a }
end

function Color:format()
  return self.r / 255, self.g / 255, self.b / 255, self.a
end

function Color:debug()
  local r, g, b, a = self:format()
  print("   RGBA(" .. self.r .. ", " .. self.g .. ", " .. self.b .. ", " .. self.a .. ")")
  print("   Formatted(" .. r .. ", " .. g .. ", " .. b .. ", " .. a .. ")")
end

return Color
