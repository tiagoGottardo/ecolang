local assert = require("luassert")
local Text = require 'components.text'

describe('Text module test suite', function()
  it('should match correct text props', function()
    local newText = Text:new({ label = "Foo", fontSize = 10, wrapLimit = 400 })
    assert.are_equal(newText.label, 'Foo')
    assert.are_equal(newText.fontSize, 10)
    assert.are_equal(newText.wrapLimit, 400)
  end)

  it('should match changed text props', function()
    local newText = Text:new({ label = "Foo", fontSize = 42, wrapLimit = 237 })
    newText:set({ label = "Bar", fontSize = 10, wrapLimit = 0 })
    assert.are_equal(newText.label, 'Bar')
    assert.are_equal(newText.fontSize, 10)
    assert.are_equal(newText.wrapLimit, 0)
  end)
end)
