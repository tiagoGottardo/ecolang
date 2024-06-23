local animalButtons = {}
local imagesPath = "Animals/"
animalButtons.__index = animalButtons

local Button = require "components.button"

local offsetOptionsV = 90
local offsetOptionsH = 160

function animalButtons:new()
  local instance = setmetatable({}, self)
  instance.options = {}

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
      content = { name = imagesPath .. Game.level1.animals[1] .. ".png" },
    },
    {
      position = { WINDOW_WIDTH / 2 + offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 - offsetOptionsV },
      content = { name = imagesPath .. Game.level1.animals[2] .. ".png" },
    },
    {
      position = { WINDOW_WIDTH / 2 - offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 + offsetOptionsV },
      content = { name = imagesPath .. Game.level1.animals[3] .. ".png" },
    },
    {
      position = { WINDOW_WIDTH / 2 + offsetOptionsH, (WINDOW_HEIGHT + 108) / 2 + offsetOptionsV },
      content = { name = imagesPath .. Game.level1.animals[4] .. ".png" },
    },
  }

  for i, config in ipairs(buttonConfigurations) do
    instance.options[i] = Button:new(optionsTemplate)
    instance.options[i]:set(config)
  end

  for i, option in ipairs(instance.options) do
    option.value = i
  end

  return instance
end

function animalButtons:draw()
  local instance = self or {}
  for _, option in ipairs(instance.options) do
    option:draw()
  end
end

function animalButtons:mousepressed(x, y, button, verifyCorrectAnswer)
  self.options[1]:onClick(x, y, button, verifyCorrectAnswer, self.options[1].value)
  self.options[2]:onClick(x, y, button, verifyCorrectAnswer, self.options[2].value)
  self.options[3]:onClick(x, y, button, verifyCorrectAnswer, self.options[3].value)
  self.options[4]:onClick(x, y, button, verifyCorrectAnswer, self.options[4].value)
end

return animalButtons
