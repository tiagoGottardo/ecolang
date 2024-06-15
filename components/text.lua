local Text = {}
local Color = require 'components.color'
Text.__index = Text

local t = require 'utils.input'

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
  self.fontSize = t.sanitizeMin(textTable.fontSize, 0) or self.fontSize or 24
  self.wrapLimit = t.sanitizeMin(textTable.wrapLimit, 0) or self.wrapLimit or 0
end

function Text:draw(X, Y)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color:format())

  local myFont       = love.graphics.newFont("assets/Sniglet/Sniglet-Regular.ttf", self.fontSize)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(myFont)

  local label     = self.label
  local textWidth = myFont:getWidth(self.label)

  if self.wrapLimit > 0 then
    local textWrapped = {}
    textWidth, textWrapped = myFont:getWrap(label, self.wrapLimit)
    label = ''
    for i, v in ipairs(textWrapped) do
      if i > 0 then
        label = label .. '\n'
      end
      label = label .. v
    end
  end

  local _, linesQnt = label:gsub("\n", "")
  linesQnt = linesQnt + 1
  local textHeight = linesQnt * myFont:getHeight()

  love.graphics.print(label, myFont, X, Y, 0, 1, 1, textWidth / 2, textHeight / 2)

  love.graphics.setFont(previousFont)
  love.graphics.setColor(r, g, b, a)
end

function Text:debug()
  print("   Text(" .. self.label .. ", FontSize:" .. self.fontSize .. ", WrapLimit:" .. self.wrapLimit .. ")")
end

return Text
