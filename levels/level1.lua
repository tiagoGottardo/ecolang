local Level1 = {}
require("utils.colors")
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
  correctSound = love.audio.newSource("assets/sounds/" .. Game.animal .. ".mp3", "static")

  animals = animalButtons:new()
  container = centralContainer:new()
  header = upHeader:new()
  headerLabel = componentHeaderLabel:new(Game.animal)
  soundHeader = componentSoundHeader:new()

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4, })

  helpButton = componentHelpButton:new()

  isTimeOverModal = componentTimeOver:new()

  successModal = componentSucces:new("IR PARA A FASE 2")

  failedModal = componentFailed:new()

  cursor = Cursor:new {
    botoes = { animals.options[1], animals.options[2], animals.options[3], animals.options[4], soundHeader, helpButton }
  }
end

local function verifyCorrectAnswer(answer)
  answer = answer or 1
  if Game.animal == Game.level1.animals[answer] then
    if Game.level1.currentRound >= Game.level1.totalRounds then
      successModal.hidden = false
      cursor:set { botoes = { successModal.button } }
    else
      Game.level1.next()
      Level1.load()
    end
  else
    failedModal.hidden = false
    cursor:set { botoes = { failedModal.button } }
  end
end

function Level1.mousepressed(x, y, button)
  if (failedModal.hidden and successModal.hidden and isTimeOverModal.hidden) then
    animals:mousepressed(x, y, button, verifyCorrectAnswer)
    soundHeader:onClick(x, y, button, (function() correctSound:play() end))
    helpButton:onClick(x, y, button, (function()
      Game.currentLevel = 2
      Game.load()
    end))
  end

  if not failedModal.hidden then
    failedModal.button:onClick(x, y, button, (function()
      Game.load()
    end))
  end
  if not successModal.hidden then
    successModal.button:onClick(x, y, button, (function()
      Game.level2               = {}
      Game.level2.currentRound  = 0
      Game.level2.totalRounds   = 10
      Game.level2.next = function()
        Game.level2.currentRound = Game.level2.currentRound + 1
        Game.animal = Game.animals[1+math.floor(math.random()*#Game.animals)] or "MACACO"
      end
      Game.level2.next()
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
  Game.timer:update(dt)
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
