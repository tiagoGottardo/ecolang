local centralContainer = {}
centralContainer.__index = centralContainer

local Object = require("components.object")
local Button = require("components.button")

function centralContainer:new()
	local instance = setmetatable({}, self)
	instance.__index = instance

	instance.footer = Object:new({
		color = LightGreen,
		position = { WINDOW_WIDTH / 2, 460 },
		shape = {
			width = 768,
			height = 108,
		},
	})

	instance.footer.color:set({ a = 0.69 })

	instance.soundFooter = Button:new({
		position = { WINDOW_WIDTH / 2 - 330, 460 },
		shape = {
			width = 88,
			height = 88,
			radius = 20,
		},
		content = {
			kind = "image",
			name = "sound.png",
			width = 58,
			height = 58,
		},
		color = { a = 0.51 },
	})

	instance.proximoFooter = Button:new({
		position = { WINDOW_WIDTH / 2 + 330, 460 },
		shape = {
			width = 88,
			height = 88,
			radius = 20,
		},
		content = {
			kind = "image",
			name = "prox.png",
			width = 58,
			height = 58,
		},
		color = { a = 0.51 },
	})

	return instance
end

function centralContainer:draw()
	local instance = self or {}

	instance.footer:draw()
	instance.soundFooter:draw()
	instance.proximoFooter:draw()
end

return centralContainer
