local assert = require("luassert")

local Rectangle = require 'components.rectangle'

local function areShapesEqual(s1, s2)
  return s1.__index == s2.__index and s1.width == s2.width and s1.height == s2.height and s1.radius == s2.radius
end

describe('Rectangle module test suite', function()
  it('should match match both starts', function()
    local rect1 = Rectangle:new({ width = 0, height = 0, radius = 0 })
    local rect2 = Rectangle:new()
    assert.truthy(areShapesEqual(rect1, rect2))
  end)

  it('should match both rectangles', function()
    local rect1 = Rectangle:new()
    rect1:set({ width = 42 })
    rect1:set({ height = 237 })
    local rect2 = Rectangle:new({ width = 42, height = 237 })
    assert.truthy(areShapesEqual(rect1, rect2))
  end)

  it('should set 0 to shape props', function()
    local rect1 = Rectangle:new({ width = -293, height = -34.4, radius = 0.00 })
    local rect2 = Rectangle:new({ radius = 0 })
    assert.truthy(areShapesEqual(rect1, rect2))
  end)

  it('should return props correctly', function()
    local rect1 = Rectangle:new({ width = 237, height = 273, radius = 6 })
    local props = rect1:get()
    assert.are_equal(rect1.width, props.width)
    assert.are_equal(rect1.height, props.height)
    assert.are_equal(rect1.radius, props.radius)
  end)
end)

local Circle = require 'components.circle'

describe('Circle module test suite', function()
  it('should match match both starts', function()
    local circ1 = Circle:new({ radius = 0 })
    local circ2 = Circle:new()
    assert.truthy(areShapesEqual(circ1, circ2))
  end)

  it('should match both circles', function()
    local circ1 = Circle:new()
    circ1:set({ radius = 42 })
    local circ2 = Circle:new({ radius = 42 })
    circ2:set()
    assert.truthy(areShapesEqual(circ1, circ2))
  end)

  it('should set 0 to shape props', function()
    local circ1 = Circle:new({ radius = -1998 })
    local circ2 = Circle:new({ radius = 0 })
    assert.truthy(areShapesEqual(circ1, circ2))
  end)

  it('should return props correctly', function()
    local circ1 = Circle:new({ radius = 6 })
    local props = circ1:get()
    assert.are_equal(circ1.radius, props.radius)
  end)
end)

local Square = require 'components.square'

describe('Square module test suite', function()
  it('should match match both starts', function()
    local square1 = Square:new({ size = 0, radius = -10 })
    local square2 = Square:new()
    assert.truthy(areShapesEqual(square1, square2))
  end)

  it('should match both squares', function()
    local square1 = Square:new()
    square1:set({ radius = 42, size = 0 })
    local square2 = Square:new({ radius = 40 + 2, size = 30 })
    square2:set({ size = nil })
    assert.truthy(areShapesEqual(square1, square2))
  end)

  it('should set 0 to shape props', function()
    local square1 = Square:new({ radius = -1998, size = -4 })
    local square2 = Square:new({ radius = 0 })
    assert.truthy(areShapesEqual(square1, square2))
  end)

  it('should return props correctly', function()
    local square1 = Square:new({ radius = 6 })
    local props = square1:get()
    assert.are_equal(square1.radius, props.radius)
    assert.are_equal(square1.size, props.size)
  end)
end)
