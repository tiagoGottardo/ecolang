local Color = {}
Color.__index = Color

local t = require 'utils.input'

function Color:new(colorTable)
  colorTable = colorTable or {}
  local instance = setmetatable({}, Color)
  instance:set(colorTable)
  return instance
end

function Color:set(colorTable)
  colorTable = colorTable or {}
  self.r = t.sanitizeRange(colorTable.r or colorTable[1], 0, 255) or self.r or 255
  self.g = t.sanitizeRange(colorTable.g or colorTable[2], 0, 255) or self.g or 255
  self.b = t.sanitizeRange(colorTable.b or colorTable[3], 0, 255) or self.b or 255
  self.a = t.sanitizeRange(colorTable.a or colorTable[4], 0, 1) or self.a or 1
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
