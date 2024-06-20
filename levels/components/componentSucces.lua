local componentSucces = {}
componentSucces.__index = componentSucces

local Object = require("components.object")
local Text = require("components.text")
local Button = require("components.button")

function componentSucces:new(buttonLabel)
	local instance = setmetatable({}, self)

	instance.background = Object:new({
		shape = {
			width = 600,
			height = 300,
			radius = 20,
		},
		color = LightGreen,
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
	})
	instance.background:set({ color = { a = 1 } })
	instance.text = Text:new({
		label = "PARABÉNS",
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
			label = buttonLabel,
			fontSize = 30,
			color = Black,
		},
	})
	instance.hidden = true

	return instance
end

function componentSucces:draw()
	self.background:draw()
	self.background:setBorder()
	self.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
	self.button:draw()
	self.button:setBorder()
end

return componentSucces
