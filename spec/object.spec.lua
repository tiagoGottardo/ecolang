local assert = require("luassert")
local Object = require 'components.object'
require 'utils.colors'
local Rectangle = require 'components.rectangle'
local Circle = require 'components.circle'

local function areTablesEqual(t1, t2, tableSize)
  for v = 1, tableSize do
    if t1[v] ~= t2[v] then
      return false
    end
  end
  return true
end

describe('Object module test suite', function()
  it('should return correct object props', function()
    local obj = Object:new({ color = Blue, shape = { kind = 'circle', radius = 29 }, position = { 40, 40 } })
    assert.truthy(areTablesEqual(obj.position:get(), { x = 40, y = 40 }, 4))
    assert.truthy(areTablesEqual(obj.color:get(), { 111, 168, 220, 1 }, 4))
    assert.are_equal(getmetatable(obj.shape), Circle)
  end)

  it('should return default object correctly', function()
    local obj = Object:new()
    assert.truthy(areTablesEqual(obj.position:get(), { x = 0, y = 0 }, 2))
    assert.truthy(areTablesEqual(obj.color:get(), { 255, 255, 255, 1 }, 4))
    assert.are_equal(getmetatable(obj.shape), Rectangle)
  end)

  it('should return default object correctly', function()
    local obj = Object:new()
    assert.truthy(areTablesEqual(obj.position:get(), { x = 0, y = 0 }, 2))
    assert.truthy(areTablesEqual(obj.color:get(), { 255, 255, 255, 1 }, 4))
    assert.are_equal(getmetatable(obj.shape), Rectangle)
  end)

  it('should not set width to circle shape', function()
    local obj = Object:new({ shape = { kind = 'circle' } })
    obj.shape:set({ width = 10, radius = 10 })

    assert.are_equal(obj.shape:get().width, nil)
  end)

  it('should call shape draw function', function()
    local obj = Object:new({ shape = { kind = 'circle' } })
    obj.shape:set({ radius = 10 })
    local circleDraw = spy.new(function() end)
    obj.shape.draw = circleDraw
    obj:draw()
    assert.spy(circleDraw).called(1)
  end)
end)
