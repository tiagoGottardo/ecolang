require("utils.colors")
local Timer = require 'src.timer'
Game = {}
Game.timer = Timer:new({ fontSize = 20, color = Black })

local fundo

Game.levels = {
  require "levels.menu",
  require "levels.level1pre",
  require "levels.level1",
  require "levels.level2",
  require "levels.level3",
  require "levels.sobre"
}

Game.currentLevel = 1

function Game.load()
  fundo = love.graphics.newImage("assets/images/fundo.png")
  Game.levels[Game.currentLevel].load()
end

function Game.update(dt)
  Game.levels[Game.currentLevel].update(dt)
end

function Game.draw()
  love.graphics.setBackgroundColor(1, 1, 1)
  love.graphics.draw(fundo, 0, 0, 0, love.graphics.getWidth() / fundo:getWidth(),
    love.graphics.getHeight() / fundo:getHeight())
  Game.levels[Game.currentLevel].draw()
end

function Game.keypressed(key)
  if key == "n" then
    Game.currentLevel = Game.currentLevel % #Game.levels + 1
    Game.levels[Game.currentLevel].load()
  end
  Game.levels[Game.currentLevel].keypressed(key)
end

function Game.mousepressed(x, y, button, istouch, presses)
  if (Game.levels[Game.currentLevel].mousepressed) then
    Game.levels[Game.currentLevel].mousepressed(x, y, button, istouch, presses)
  end
end

function Game.mousereleased(x, y, button, istouch, presses)
  if (Game.levels[Game.currentLevel].mousereleased) then
    Game.levels[Game.currentLevel].mousereleased(x, y, button, istouch, presses)
  end
end

function Game.mousemoved(x, y, dx, dy, istouch)
  if(Game.levels[Game.currentLevel].mousemoved) then
    Game.levels[Game.currentLevel].mousemoved(x, y, dx, dy, istouch)
  end
end

function Game.resize()
  if (Game.levels[Game.currentLevel].resize) then
    Game.levels[Game.currentLevel].resize()
  end
end

return Game
