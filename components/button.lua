local Object = require 'components.object'

local Button = setmetatable({}, { __index = Object })
Button.__index = Button

function Button:onClick(x, y, button, fn, input)
  if button == 1 then
    local width = self.shape.width or self.shape.size or self.shape.radius
    local height = self.shape.height or self.shape.size or self.shape.radius
    if x <= self.position.x + width / 2 and x >= self.position.x - width / 2 and y <= self.position.y + height / 2 and y >= self.position.y - height / 2 then
      fn(input)
    end
  end
end

return Button
