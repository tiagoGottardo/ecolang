local Level2 = {}
require("utils.colors")
local utils = require 'utils'
local Object = require 'components.object'
local Timer = require 'src.timer'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"

local cursor = {}
local Cursor = require 'src.cursor'

local container = {}
local centralContainer = require 'levels.components.centralContainer'

local header = {}
local upHeader = require "levels.components.upHeader"

local headerLabel = {}
local componentHeaderLabel = require "levels.components.componentHeaderLabel"

local soundHeader = {}
local componentSoundHeader = require "levels.components.componentSoundHeader"

local logo = {}

local helpButton = {}
local componentHelpButton = require "levels.components.componentHelpButton"

local animalSound
local animalImage

local successModal
local componentSucces = require "levels.components.componentSucces"

local failedModal
local componentFailed = require "levels.components.componentFailed"

local isTimeOverModal
local componentTimeOver = require "levels.components.componentTimeOver"

local evenTriggered = false
local letterPressed
local letterGoal
local keyboardImage
local selectedKey

local verifyTimer = nil
local verifyDelay = 0.5

local function getKeyPosition(key)
  local keys = {
    ['A'] = { 314, 257 },
    ['B'] = { 520, 302 },
    ['C'] = { 429, 302 },
    ['D'] = { 405, 257 },
    ['E'] = { 394, 213 },
    ['F'] = { 452, 257 },
    ['G'] = { 497, 257 },
    ['H'] = { 543, 257 },
    ['I'] = { 623, 213 },
    ['J'] = { 589, 257 },
    ['K'] = { 635, 257 },
    ['L'] = { 681, 257 },
    ['M'] = { 612, 302 },
    ['N'] = { 566, 302 },
    ['O'] = { 669, 213 },
    ['P'] = { 715, 213 },
    ['Q'] = { 302, 213 },
    ['R'] = { 440, 213 },
    ['S'] = { 360, 257 },
    ['T'] = { 486, 213 },
    ['U'] = { 577, 213 },
    ['V'] = { 475, 302 },
    ['W'] = { 348, 213 },
    ['X'] = { 383, 302 },
    ['Y'] = { 531, 213 },
    ['Z'] = { 337, 302 }
  }
  return keys[key] or { 0, 0 }
end

function Level2.load()
  evenTriggered = false
  animalSound = love.audio.newSource("assets/sounds/" .. Game.animal .. ".mp3", "static")

  local keyboardScale = .6
  keyboardImage = Object:new {
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    color = { a = 0 },
    shape = {
      width = 780 * keyboardScale,
      height = 297 * keyboardScale
    },
    content = {
      kind = 'image',
      name = 'keyboard.png',
      width = 780 * keyboardScale,
      height = 297 * keyboardScale
    }
  }

  selectedKey = Object:new {
    position = getKeyPosition(utils.string:firstUtf8Char(Game.animal)),
    color = Red,
    shape = {
      width = 40,
      height = 40,
      radius = 5
    }
  }
  selectedKey:set {
    color = { a = .3 }
  }

  -- letterGoal = Object:new {
  --   color = { a = 0 },
  --   position = { WINDOW_WIDTH * 2 / 6, 97 },
  --   shape = {
  --     width = 100,
  --     height= 88,
  --     radius=10
  --   },
  --   content = {
  --     color = Red,
  --     fontSize = 70,
  --     label = utils.string:firstUtf8Char(animal)
  --   }
  -- }

  --letterGoal = Object:new {
  --  color = Black,
  --  position = { WINDOW_WIDTH * 2 / 6, 97 },
  --  shape = {
  --    width = 100,
  --    height= 88,
  --    radius=10
  --  },
  --  content = {
  --    color = White,
  --    fontSize = 70,
  --    label = utils.string:firstUtf8Char(animal)
  --  }
  --}


  letterPressed = Object:new {
    color = White,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT * 4 / 5 },
    shape = {
      width = 100,
      height = 100,
      radius = 10
    },
    content = {
      color = Black,
      fontSize = 60,
      label = ''
    }
  }

  container = centralContainer:new()

  header = upHeader:new()

  headerLabel = componentHeaderLabel:new(nil)

  animalImage = Object:new {
    position = { WINDOW_WIDTH * 4 / 5, 97 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = 'image',
      width = 70,
      height = 70,
      name = "Animals/" .. Game.animal .. ".png"
    }
  }

  soundHeader = componentSoundHeader:new()

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4, })

  helpButton = componentHelpButton:new()

  isTimeOverModal = componentTimeOver:new()

  successModal = componentSucces:new("IR PARA A FASE 3")

  failedModal = componentFailed:new()

  cursor = Cursor:new {
    botoes = { soundHeader, helpButton }
  }
end

local function verifyCorrectAnswer(answer)
  answer = answer or ""
  local rightLetter = utils.string:firstUtf8Char(Game.animal)
  if rightLetter == answer then
    if Game.level2.currentRound >= Game.level2.totalRounds then
      successModal.hidden = false
      cursor:set { botoes = { successModal.button } }
    else
      Game.level2.next()
      Level2.load()
    end
  else
    table.insert(Game.play.lvl2.errors, { tentativa = answer, resposta = rightLetter })
    Game.play.score = Game.play.score - 20

    letterPressed:set {
      content = {
        label = rightLetter,
        color = Red
      }
    }
    letterPressed:set {
      content = {
        color = { a = .5 }
      }
    }
    --failedModal.hidden = false
    --cursor:set { botoes = { failedModal.button } }
  end
end

function Level2.mousepressed(x, y, button)
  -- print(utils.string:tostring{x, y})
  if (failedModal.hidden and successModal.hidden and isTimeOverModal.hidden) then
    soundHeader:onClick(x, y, button, (function() animalSound:play() end))
    helpButton:onClick(x, y, button, (function()
      Game.currentLevel = 15
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
      Game.level3               = {}
      Game.level3.currentRound  = 0
      Game.level3.totalRounds   = 10
      Game.level3.next = function()
        Game.level3.currentRound = Game.level3.currentRound + 1
        -- Game.animal = Game.animals[1+math.floor(math.random()*#Game.animals)] or "MACACO"
        local newAnimal = Game.animals[1+math.floor(math.random()*#Game.animals)]
        while newAnimal==Game.animal do
          newAnimal = Game.animals[1+math.floor(math.random()*#Game.animals)]
        end
        Game.animal = newAnimal
      end
      Game.level3.next()
      Game.currentLevel = 6
      Game.play.lvl2.time = Game.timer.timePassed - Game.play.lvl1.time
      Game.play.score = Game.play.score + 2 * math.floor(Game.timer.timerDuration - Game.timer.timePassed)
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

function Level2.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level2.update(dt)
  Game.timer:update(dt)

  if verifyTimer and love.timer.getTime() - verifyTimer[1] > verifyDelay then
    verifyCorrectAnswer(verifyTimer[2])
    verifyTimer = nil
  end
  if Game.timer:isTimeOver() and not evenTriggered then
    isTimeOverModal.hidden = false
    cursor:set { botoes = { isTimeOverModal.button } }
    evenTriggered = true
  end
end

function Level2.draw()
  container:draw()
  header:draw()
  headerLabel:draw()

  local myFont       = love.graphics.newFont("assets/Sniglet/Sniglet-Regular.ttf", 65)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(myFont)


  local highlightColor = { 0.8, 0, 0, 1 }
  local regularColor = { 0.027, 0.545, 0.141, 1 }
  local coloredText = { highlightColor, utils.string:firstUtf8Char(Game.animal:upper()), regularColor, ' ' .. Game.animal:sub(2) }
  local textWidth = 0
  local textHeight = myFont:getHeight()
  for i, v in ipairs(coloredText) do
    if i % 2 == 0 then
      textWidth = textWidth + myFont:getWidth(v)
    end
  end
  love.graphics.print(coloredText, myFont, WINDOW_WIDTH / 2 - textWidth / 2, 97 - textHeight / 2)

  soundHeader:draw()
  animalImage:draw()
  Game.timer:draw(900, 20)
  logo:draw(325 * 0.2, 152 * 0.2)
  keyboardImage:draw()
  selectedKey:draw()
  selectedKey:setBorder(Red)
  letterPressed:draw()
  letterPressed:setBorder()
  --letterGoal:draw()
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

function Level2.textinput(text)
  if text then
    text = utils.string:firstUtf8Char(text:upper())
    letterPressed:set {
      content = {
        label = text,
        color = { 0, 0, 0, 1 }
      }
    }
    verifyTimer = { love.timer.getTime(), text }
  end
end

return Level2
