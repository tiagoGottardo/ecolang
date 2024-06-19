local timeOverModal = {}
timeOverModal.__index = timeOverModal

local Object = require("components.object")
local Text = require "components.text"
local Button = require "components.button"

function timeOverModal:new(correct)
	local isTimeOverModal = setmetatable({}, self)

	isTimeOverModal = Object:new({
        shape = {
          width = 600,
          height = 300,
          radius = 20
        },
        color = Red,
        position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
      })
    
      isTimeOverModal:set({ color = { a = 1 } })
    
      isTimeOverModal.text = Text:new({
        label = "O TEMPO ACABOU",
        fontSize = 40,
        color = Black
      })
      
      isTimeOverModal.button = Button:new({
        shape = {
          width = 400,
          height = 75,
          radius = 40
        },
        position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + 50 },
        content = {
          label = "IR PARA O MENU",
          fontSize = 30,
          color = Black
        }
      })
      isTimeOverModal.hidden = true

	return isTimeOverModal
end

return timeOverModal


