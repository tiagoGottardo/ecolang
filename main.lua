local Game = require "src.game"

love.load = function (args)
  Game.load()
end

love.update = function(dt)
  Game.update(dt)
end

love.draw = function(dt)
  Game.draw()
end

function love.keypressed(key)
    Game.keypressed(key)
end

