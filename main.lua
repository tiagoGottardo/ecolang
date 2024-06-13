love = require("love")
local Game = require "src.game"

local isFullscreen = false

love.load = function(args)
  love.window.setMode(1024, 558, { resizable = true, minwidth = 400, minheight = 300 })
  Game.load()
end

love.update = function(dt)
  Game.update(dt)
end

love.draw = function(dt)
  Game.draw()
end

function love.keypressed(key)
  if key == "f11" then
    -- Alterna entre tela cheia e janela
    isFullscreen = not isFullscreen
    love.window.setFullscreen(isFullscreen)
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

love.resize = Game.resize
love.mousereleased = Game.mousereleased
love.mousepressed = Game.mousepressed
