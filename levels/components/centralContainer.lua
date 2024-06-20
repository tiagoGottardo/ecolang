local centralContainer = {}
centralContainer.__index = centralContainer

local Object = require("components.object")

function centralContainer:new(label)
	local instance = Object:new({
		color = LightGreen,
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
		shape = {
			width = 768,
			height = 471,
		},
	})

	if label then
		instance:set({
			content = {
				kind = "text",
				color = Black,
				fontSize = 40,
				label = label,
				wrapLimit = instance.shape.width * 0.9,
			},
		})
	end

	return instance
end

return centralContainer
