local componentSoundHeader = {}
componentSoundHeader.__index = componentSoundHeader

local Button = require("components.button")

function componentSoundHeader:new(correct)
	local instance = setmetatable({}, self)

	instance = Button:new({
        position = { WINDOW_WIDTH / 2 - 330, 97 },
        shape = {
          width = 88,
          height = 88,
          radius = 20,
        },
        content = {
          kind = 'image',
          name = 'sound.png',
          width = 58,
          height = 58
        },
        color = { a = 0.51 }
      })

	return instance
end

return componentSoundHeader



