local componentHelpButton = {}
componentHelpButton.__index = componentHelpButton

local Button = require("components.button")

function componentHelpButton:new(correct)
	local instance = setmetatable({}, self)

	instance = Button:new({
        shape = {
          width = 70,
          height = 70,
          radius = 20
        },
        content = {
          kind = 'image',
          name = 'question.png',
          width = 70,
          height = 70
        },
        position = { 960, 494 }
      })

	return instance
end

return componentHelpButton
