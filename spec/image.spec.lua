local assert = require("luassert")
local Image = require 'components.image'

describe('Image module test suite', function()
  it('should return default image', function()
    local newImage = Image:new({}, (function() end))
    assert.are_same(newImage.name, 'default.png')
    assert.are_equal(newImage.width, 200)
    assert.are_equal(newImage.height, 200)
  end)

  it('should match images with incorrect input', function()
    local newImage = Image:new({ height = 200 }, (function() end))
    newImage:set({ name = "logo.png", width = -100 }, (function() end))
    assert.are_same(newImage.name, 'logo.png')
    assert.are_equal(newImage.width, 0)
    assert.are_equal(newImage.height, 200)
  end)
end)
