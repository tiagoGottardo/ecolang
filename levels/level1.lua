local Level1 = {}
require("utils.colors")
local Object = require "components.object"
local container = {}
local header = {}
local i = 1

function Level1.load()
  container = Object:new({ position = { 10, 50 } })
  container.color:set(DarkGreen)
  container.shape:set({ width = 200, height = 100, radius = 20 })
end

function Level1.update(dt)
  i = i + 1 -- Atualizar lógica
  if i % 2 == 0 then
    container.color:set(LightGreen)
  else
    container.color:set(DarkGreen)
  end
end

function drawCenteredText(rectX, rectY, rectWidth, rectHeight, text)
  local font       = love.graphics.getFont()
  local textWidth  = font:getWidth(text)
  local textHeight = font:getHeight()
  love.graphics.print(text, rectX + rectWidth / 2, rectY + rectHeight / 2, 0, 1, 1, textWidth / 2, textHeight / 2)
end

function Level1.draw()
  local x, y = 100, 60
  local w, h = 400, 40
  love.graphics.setColor({ 0, 0, 0, 1 })
  love.graphics.rectangle("line", x, y, w, h)
  drawCenteredText(x, y, w, h, "I print my LÖVE")
end

-- function Level1.draw()
--   love.graphics.print("Fase1", 400, 300)
--   container:draw()
--   container:debug()
--   -- Desenhar elementos
-- end

function Level1.keypressed(key)
  if key == 'q' then
    love.event.quit()
  end
end

return Level1
