local componentFailed = {}
componentFailed.__index = componentFailed

local Object = require("components.object")
local Text = require("components.text")
local Button = require("components.button")

function componentFailed:new(correct)
	failedModal = Object:new({
		shape = {
			width = 600,
			height = 300,
			radius = 20,
		},
		color = Orange,
		position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
	})
	failedModal.text = Text:new({
		label = "TENTE NOVAMENTE",
		fontSize = 40,
		color = Black,
	})
	failedModal.button = Button:new({
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
	failedModal.hidden = true

	return failedModal
end

return componentFailed
