local componentVideo = {}
componentVideo.__index = componentVideo

local Button = require 'components.button'

function componentVideo:new(tab)
  tab = type(tab)=='table' and tab or {}

  local instance = setmetatable({}, self)
  instance.container = Button:new {
    shape = {
      width = 768,
      height = 768*0.5625,
      radius = 0
    },
    content = {
      kind = 'video',
      name = 'default.ogv',
      width = 768,
      height = 768*0.5625
    },
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 }
  }
  instance.container:set(tab)

	return instance
end

function componentVideo:onClick(x, y, button, fn, input)
  self.container:onClick(x, y, button,
  function(input)
    if self.container.content.video:isPlaying() then
      self.container.content.video:pause()
    else
      self.container.content.video:play()
    end
  end, input)
end

function componentVideo:draw()
  self.container:draw()
end

function componentVideo:isPlaying()
  return self.container.content.video:isPlaying()
end

function componentVideo:stop()
  if self:isPlaying() then
    self.container.content.video:pause()
  end
  self.container.content.video:rewind()
end

function componentVideo:play()
  self.container.content.video:play()
end

function componentVideo:pause()
  self.container.content.video:pause()
end

return componentVideo
