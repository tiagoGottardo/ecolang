local animalButtons = {}
animalButtons.__index = animalButtons

local Button = require "components.button"

local answers = { "MACACO", "LEÃO", "ABELHA", "CACHORRO" }

local offsetOptionsV = 90
local offsetOptionsH = 160

function animalButtons:new()
    local options = setmetatable({}, self)

    local optionsTemplate = {
        position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
        shape = {
            width = 150,
            height = 150,
            radius = 20,
        },
        content = {
            kind = "image",
            width = 100,
            height = 100,
        },
    }
    
    local buttonConfigurations = {
        {
            position = { WINDOW_WIDTH / 2 - offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 - offsetOptionsV },
            content = { name = "monkey.png" },
        },
        {
            position = { WINDOW_WIDTH / 2 + offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 - offsetOptionsV },
            content = { name = "lion.png" },
        },
        {
            position = { WINDOW_WIDTH / 2 - offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 + offsetOptionsV },
            content = { name = "bee.png" },
        },
        {
            position = { WINDOW_WIDTH / 2 + offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 + offsetOptionsV },
            content = { name = "dog.png" },
        },
    }

	for i, config in ipairs(buttonConfigurations) do
		options[i] = Button:new(optionsTemplate)
		options[i]:set(config)
	end

	for i, option in ipairs(options) do
		option.value = answers[i]
	end

    return options
end

function animalButtons:draw()
    local options = self or {}
	for _, option in ipairs(options) do
		option:draw()
	end
end

return animalButtons
