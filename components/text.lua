local Text = {}
local Color = require 'components.color'
Text.__index = Text

function Text:new(textTable)
  textTable = textTable or {}
  local instance = setmetatable({}, Text)
  instance.color = Color:new(textTable.color)
  instance:set(textTable)
  return instance
end

function Text:set(textTable)
  textTable = textTable or {}
  self.color:set(textTable.color)
  self.label = textTable.label or self.label or ""
  self.fontSize = textTable.fontSize or self.fontSize or 24
end

function Text:draw(X, Y)
  local r, g, b, a = love.graphics.getColor() -- Previous system color
  love.graphics.setColor(self.color:format())

  local myFont       = love.graphics.newFont("assets/Sniglet/Sniglet-Regular.ttf", self.fontSize)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(myFont)

  local textWidth  = myFont:getWidth(self.label)
  local textHeight = myFont:getHeight()

  love.graphics.print(self.label, myFont, X, Y, 0, 1, 1, textWidth / 2, textHeight / 2)

  love.graphics.setFont(previousFont)
  love.graphics.setColor(r, g, b, a)
end

function Text:debug()
  print("   Text(" .. self.label .. ", " .. self.fontSize .. ")")
end

return Text
