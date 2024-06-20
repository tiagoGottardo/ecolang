local centralContainer = {}
centralContainer.__index = centralContainer

local Object = require("components.object")

function centralContainer:new()
	local instance = setmetatable({}, self)
    
	instance = Object:new({
		color = LightGreen,
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
		shape = {
			width = 768,
			height = 471,
		},
	})

	return instance
end

return centralContainer
