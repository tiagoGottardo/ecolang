local shape = require "src.shape"
local Level1 = {}
local container = {}
local header = {}

function Level1.load()
  container = shape:newRect({ width = 80, height = 80, x = 50, y = 50 })
  container:setColor({ 148, 221, 114, 42 })
  header = shape:newRect({ width = 80, height = 15 })
  header:setColor({ 148, 221, 204, 69 })
  header:setPosition({ 50, 7.5 }, container)
end

function Level1.update(dt)

end

function Level1.draw()
  love.graphics.setBackgroundColor(1, 1, 1)
  container:draw(love)
  header:draw(love)

  love.graphics.print("Fase1", 400, 300)
end

function Level1.keypressed(key)
  if key == "q" then
    love.event.quit()
  end
end

return Level1
