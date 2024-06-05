local Game = {}

Game.levels = {
    require "levels.menu",
    require "levels.level1",
    require "levels.level2",
    require "levels.level3"
}

Game.currentLevel = 1

function Game.load()
    Game.levels[Game.currentLevel].load()
end

function Game.update(dt)
    Game.levels[Game.currentLevel].update(dt)
end

function Game.draw()
    Game.levels[Game.currentLevel].draw()
end

function Game.keypressed(key)
    if key == "n" then
        Game.currentLevel = Game.currentLevel % #Game.levels + 1
        Game.levels[Game.currentLevel].load()
    end
    Game.levels[Game.currentLevel].keypressed(key)
end

function Game.mousereleased( x, y, button, istouch, presses )
  if(Game.levels[Game.currentLevel].mousereleased) then
    Game.levels[Game.currentLevel].mousereleased(x, y, button, istouch, presses)
  end
end

return Game
