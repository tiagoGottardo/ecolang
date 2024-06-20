local componentFailed = {}
componentFailed.__index = componentFailed

local Object = require("components.object")
local Text = require("components.text")
local Button = require("components.button")

function componentFailed:new(correct)
	local instance = setmetatable({}, self)

	instance.background = Object:new({
		shape = {
			width = 600,
			height = 300,
			radius = 20,
		},
		color = Orange,
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
	})
	instance.text = Text:new({
		label = "TENTE NOVAMENTE",
		fontSize = 40,
		color = Black,
	})
	instance.button = Button:new({
		shape = {
			width = 400,
			height = 75,
			radius = 40,
		},
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + 50 },
		content = {
			label = "JOGAR NOVAMENTE",
			fontSize = 30,
			color = Black,
		},
	})
	instance.hidden = true

	return instance
end

function componentFailed:draw()
	self.background:draw()
	self.background:setBorder()
	self.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
	self.button:draw()
	self.button:setBorder()
end

return componentFailed
