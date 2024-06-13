love = require("love")
local Game = require "src.game"
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

love.load = function(args)
  Game.load()
end

love.update = function(dt)
  Game.update(dt)
end

love.draw = function(dt)
  Game.draw()
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  elseif key == "f10" then
    -- Restaura a janela
    isFullscreen = false
    love.window.setFullscreen(isFullscreen)
    love.window.restore()
  elseif key == "f9" then
    -- Minimiza a janela
    love.window.minimize()
  end

  Game.keypressed(key)
end

love.mousereleased = Game.mousereleased
love.mousepressed = Game.mousepressed
