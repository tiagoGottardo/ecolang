local Level1 = {}
require("utils.colors")
local Timer = require 'src.timer'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"

local cursor = {}
local Cursor = require 'src.cursor'

local container = {}
local centralContainer = require "levels.components.centralContainer"

local header = {}
local upHeader = require "levels.components.upHeader"

local headerLabel = {}
local componentHeaderLabel = require "levels.components.componentHeaderLabel"

local soundHeader = {}
local componentSoundHeader = require "levels.components.componentSoundHeader"

local animals = {}
local animalButtons = require "levels.components.animalButtons"

local logo = {}

local helpButton = {}
local componentHelpButton = require "levels.components.componentHelpButton"

local answers = { "MACACO", "LEÃO", "ABELHA", "CACHORRO" }
local animalSound = {
  ["MACACO"] = 'monkey',
  ["LEÃO"] = 'lion',
  ["ABELHA"] = 'bee',
  ["CACHORRO"] = 'dog'
}
local correct
local correctSound

local successModal
local componentSucces = require "levels.components.componentSucces"

local failedModal
local componentFailed = require "levels.components.componentFailed"

local isTimeOverModal
local componentTimeOver = require "levels.components.componentTimeOver"

local evenTriggered = false

function Level1.load()
  evenTriggered = false
  correct = answers[math.floor(love.math.random() * 4) + 1]
  correctSound = love.audio.newSource("assets/sounds/" .. animalSound[correct] .. ".mp3", "static")

  animals = animalButtons:new()
  container = centralContainer:new()
  header = upHeader:new()
  headerLabel = componentHeaderLabel:new(correct)
  soundHeader = componentSoundHeader:new()

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4, })

  helpButton = componentHelpButton:new()

  isTimeOverModal = componentTimeOver:new()

  successModal = componentSucces:new("IR PARA A FASE 2")

  failedModal =  componentFailed:new()

  cursor = Cursor:new {
    botoes = { animals.options[1], animals.options[2], animals.options[3], animals.options[4], soundHeader, helpButton }
  }
end

local function verifyCorrectAnswer(answer)
  answer = answer or ""
  if correct == answer then
    successModal.hidden = false
    cursor:set { botoes = { successModal.button } }
  else
    failedModal.hidden = false
    cursor:set { botoes = { failedModal.button } }
  end
end

function Level1.mousepressed(x, y, button)
  animals:mousepressed(x, y, button, verifyCorrectAnswer)
  soundHeader:onClick(x, y, button, (function() correctSound:play() end))
  helpButton:onClick(x, y, button, (function()
    Game.currentLevel = 2
    Game.load()
  end))
  if not failedModal.hidden then
    failedModal.button:onClick(x, y, button, (function()
      Game.load()
    end))
  end
  if not successModal.hidden then
    successModal.button:onClick(x, y, button, (function()
      Game.currentLevel = 4
      Game.load()
    end))
  end
  if not isTimeOverModal.hidden then
    isTimeOverModal.button:onClick(x, y, button, (function()
      Game.currentLevel = 1
      Game.load()
    end))
  end
end

function Level1.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level1.update(dt)
  Game.timer:update()
  if Game.timer:isTimeOver() and not evenTriggered then
    isTimeOverModal.hidden = false
    cursor:set { botoes = { isTimeOverModal.button } }
    evenTriggered = true
  end
end

function Level1.draw()
  container:draw()
  header:draw()
  headerLabel:draw()
  soundHeader:draw()
  animals:draw()
  Game.timer:draw(900, 20)
  logo:draw(325 * 0.2, 152 * 0.2)
  helpButton:draw()
  helpButton:setBorder()
  if not failedModal.hidden then
    failedModal:draw()
  end
  if not isTimeOverModal.hidden then
    isTimeOverModal:draw()
  end
  if not successModal.hidden then
    successModal:draw()
  end
end

function Level1.keypressed(key)
end

return Level1
