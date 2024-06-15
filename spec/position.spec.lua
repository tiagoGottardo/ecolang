local assert = require("luassert")
local Position = require 'components.position'

local function arePositionsEqual(p1, p2)
  for v = 1, 4 do
    if p1[v] ~= p2[v] then
      return false
    end
  end
  return true
end

describe('Position module test suite', function()
  it('should return start position', function()
    local newPosition = Position:new()
    assert.truthy(arePositionsEqual(newPosition:get(), { x = 0, y = 0 }))
  end)

  it('should match positions with incorrect input', function()
    local randomPosition = { x = 0, y = 237 }
    local newPosition = Position:new({ -10, 237 })
    assert.truthy(arePositionsEqual(randomPosition, newPosition:get()))
  end)

  it('should match colors after multiple sets', function()
    local randomPosition = { x = 42, y = 237 }
    local newPosition = Position:new({ -10, 237 })
    newPosition:set({ -123, -234234 })
    newPosition:set({ x = 12 })
    newPosition:set({ y = 237 })
    newPosition:set({ newPosition.x + 30 })
    assert.truthy(arePositionsEqual(randomPosition, newPosition:get()))
  end)

  it('should change just x position', function()
    local randomPosition = { x = 42, y = 237 }
    local newPosition = Position:new({ 10, 237 })
    newPosition:set({ x = 42 })
    assert.truthy(arePositionsEqual(randomPosition, newPosition:get()))
  end)
end)
