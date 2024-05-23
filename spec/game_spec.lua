local Game = require 'src.game'

describe('Game module', function()
  before_each(function()
    Game.currentLevel = 1
  end)

  it('should load the current level', function()
    local mockLoad = spy.new(function() end)
    Game.levels[Game.currentLevel].load = mockLoad
    Game.load()

    assert.spy(mockLoad).was_called()
  end)

  it('should update the current level', function()
    local mockUpdate = spy.new(function() end)
    Game.levels[Game.currentLevel].update = mockUpdate
    Game.update(0.1)

    assert.spy(mockUpdate).was_called_with(0.1)
  end)

  it('should switch to the next level when "n" key is pressed', function()
    Game.keypressed("n")

    assert.is_equal(Game.currentLevel, 2)
  end)

end)