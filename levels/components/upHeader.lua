local upHeader = {}
upHeader.__index = upHeader

local Object = require("components.object")

function upHeader:new()
	local instance = setmetatable({}, self)

	instance = Object:new({
		color = LightGreen,
		position = { WINDOW_WIDTH / 2, 97 },
		shape = {
			width = 768,
			height = 108,
		},
	})
	instance.color:set({ a = 0.69 })

	return instance
end

return upHeader
