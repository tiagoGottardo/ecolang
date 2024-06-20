local componentHeaderLabel = {}
componentHeaderLabel.__index = componentHeaderLabel

local Object = require("components.object")

function componentHeaderLabel:new(correct)
	local instance = setmetatable({}, self)

	instance = Object:new({
		position = { WINDOW_WIDTH / 2, 97 },
		shape = {
			width = 468,
			height = 88,
			radius = 20,
		},
		color = { a = 0.51 },
	})

	if correct then 
		instance:set({
			content = {
				label = correct,
				fontSize = 60,
				color = DarkGreen,
			}
		})
	end

	return instance
end

return componentHeaderLabel
