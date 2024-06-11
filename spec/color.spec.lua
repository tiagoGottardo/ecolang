local assert = require("luassert")
local Color = require 'components.color'
require("utils.colors")

local function areColorsEqual(color1, color2)
  for v = 1, 4 do
    if color1[v] ~= color2[v] then
      return false
    end
  end
  return true
end

describe('Color module test suite', function()
  it('should return a white color', function()
    local white = { 255, 255, 255, 1 }
    local newColor = Color:new()
    assert.truthy(areColorsEqual(newColor:get(), white))
  end)

  it('should match colors with incorrect input', function()
    local randomColor = { 0, 237, 255, 0.33 }
    local newColor = Color:new({ -10, 237, 3424, 0.33 })
    assert.truthy(areColorsEqual(randomColor, newColor:get()))
  end)

  it('should match colors after multiple sets', function()
    local randomColor = { 10, 20, 30, 0.42 }
    local newColor = Color:new({ -10, 237, 3424, 0.33 })
    newColor:set({ -123, -234234, 23423, 897687 })
    newColor:set({ 30, 20, 50, 0.42 })
    newColor:set({ nil, nil, 30, })
    newColor:set({ 10 })
    assert.truthy(areColorsEqual(randomColor, newColor:get()))
  end)


  -- Blue = { 111, 168, 220 }
  it('should match with constant correctly', function()
    local constantColor = Color:new(Blue)
    local newColor = Color:new({ 111, 168, 220 })
    assert.truthy(areColorsEqual(newColor, constantColor))
  end)

  it('should match with constant correctly', function()
    local constantColor = Color:new(Black)
    local r, g, b, a = constantColor:format()
    assert.are_equal(r, 0 / 255)
    assert.are_equal(g, 0 / 255)
    assert.are_equal(b, 0 / 255)
    assert.are_equal(a, 1)
  end)

  it('should format light green correctly', function()
    local newColor = Color:new({ 148, 221, 114, 0.49 })
    local r, g, b, a = newColor:format()
    assert.are_equal(r, 148 / 255)
    assert.are_equal(g, 221 / 255)
    assert.are_equal(b, 114 / 255)
    assert.are_equal(a, 0.49)
  end)

  it('should format dark green correctly', function()
    local newColor = Color:new({ 7, 139, 36 })
    local r, g, b, a = newColor:format()
    assert.are_equal(r, 7 / 255)
    assert.are_equal(g, 139 / 255)
    assert.are_equal(b, 36 / 255)
    assert.are_equal(a, 1)
  end)
end)
