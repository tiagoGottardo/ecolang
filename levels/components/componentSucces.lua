local componentSucces = {}
componentSucces.__index = componentSucces

local Object = require("components.object")
local Text = require("components.text")
local Button = require("components.button")

function componentSucces:new(buttonLabel)

	successModal = Object:new({
		shape = {
			width = 600,
			height = 300,
			radius = 20,
		},
		color = LightGreen,
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
	})
	successModal:set({ color = { a = 1 } })
	successModal.text = Text:new({
		label = "PARABÉNS",
		fontSize = 40,
		color = Black,
	})
	successModal.button = Button:new({
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
	successModal.hidden = true

	return successModal
end

return componentSucces
