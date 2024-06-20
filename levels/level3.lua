local Level3 = {}
require("utils.colors")
local utils = require 'utils'
local utf8 = require 'utf8'
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

local animals = { "MACACO", "LEÃO", "ABELHA", "CACHORRO" }
local animalsImages = {
  ["MACACO"] = 'monkey.png',
  ["LEÃO"] = 'lion.png',
  ["ABELHA"] = 'bee.png',
  ["CACHORRO"] = 'dog.png'
}
local animalsSounds = {
  ["MACACO"] = 'monkey.mp3',
  ["LEÃO"] = 'lion.mp3',
  ["ABELHA"] = 'bee.mp3',
  ["CACHORRO"] = 'dog.mp3'
}
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

local letterIndex =1
local animal

local function getKeyPosition(key)
  local keys={
    ['A'] = {314, 257}, -- {314, 256}
    ['C'] = {429, 301}, -- {429, 301}
    ['L'] = {681, 257}, -- {681, 257}
    ['M'] = {612, 301}  -- {612, 301}
  }
  return keys[key] or { 0, 0 }
end

local function firstUtf8Char(str)
  if type(str)~='string' then
    return ''
  end
  for _, c in utf8.codes(str) do
    return utf8.char(c)
  end
  return ''
end

function Level3.load()
  letterIndex =1
  evenTriggered = false
  animal = animals[math.floor(love.math.random() * 4) + 1]
  animalSound = love.audio.newSource("assets/sounds/" .. animalsSounds[animal], "static")

  local keyboardScale=.6
  keyboardImage = Object:new {
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    color = { a = 0 },
    shape = {
      width = 780*keyboardScale,
      height = 297*keyboardScale
    },
    content = {
      kind = 'image',
      name = 'keyboard.png',
      width = 780*keyboardScale,
      height = 297*keyboardScale
    }
  }
  
  selectedKey = Object:new {
    position = getKeyPosition(firstUtf8Char(animal)),
    color = Red,
    shape = {
      width=40,
      height=40,
      radius=5
    }
  }
  selectedKey:set {
    color = { a = .3 }
  }

  letterPressed = Object:new {
    color = LightGray,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT * 4 / 5 },
    shape = {
      width = 100,
      height= 100,
      radius=10
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
    color = { a = 0.51 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = 'image',
      width = 80,
      height = 80,
      name = animalsImages[animal]
    }
  }

  soundHeader = componentSoundHeader:new()

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4, })
  
  helpButton = componentHelpButton:new()

  isTimeOverModal = componentTimeOver:new()

  successModal = componentSucces:new("VOLTAR PARA O MENU")

  failedModal =  componentFailed:new()

  cursor = Cursor:new {
    botoes = { soundHeader, helpButton }
  }
end

local function verifyCorrectAnswer(answer)
  answer = answer or ""

  local correctChar = utf8.char(utf8.codepoint(animal, utf8.offset(animal, letterIndex)))

  if correctChar == answer then
    letterIndex=letterIndex+1
  else
    --failedModal.hidden = false
    --cursor:set { botoes = { failedModal.button } }
  end

  if letterIndex > #animal then
    successModal.hidden = false
    cursor:set { botoes = { successModal.button } }
  end
end

function Level3.mousepressed(x, y, button)
  -- print(utils.string:tostring{x, y})
  if(failedModal.hidden and successModal.hidden and isTimeOverModal.hidden) then
    soundHeader:onClick(x, y, button, (function() animalSound:play() end))
    helpButton:onClick(x, y, button, (function()
      Game.currentLevel = 4
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
      Game.currentLevel = 1
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

function Level3.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level3.update(dt)
  Game.timer:update()
  if Game.timer:isTimeOver() and not evenTriggered then
    isTimeOverModal.hidden = false
    cursor:set { botoes = { isTimeOverModal.button } }
    evenTriggered = true
  end
end

function Level3.draw()
  container:draw()
  header:draw()
  headerLabel:draw()

  local myFont       = love.graphics.newFont("assets/Sniglet/Sniglet-Regular.ttf", 65)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(myFont)


  local highlightColor = { 0.8, 0, 0, 1 }
  local regularColor = { 0.027, 0.545, 0.141, 1 }
  local coloredText = { highlightColor, firstUtf8Char(animal:upper()), regularColor, ' ' .. animal:sub(2) }
  local textWidth = 0
  local textHeight = myFont:getHeight()
  for i, v in ipairs(coloredText) do
    if i%2==0 then
      textWidth=textWidth+myFont:getWidth(v)
    end
  end
  love.graphics.print(coloredText, myFont, WINDOW_WIDTH / 2 - textWidth/2, 97-textHeight/2)

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

function Level3.textinput(text)
  if text then
    local firstChar = text:sub(1, utf8.offset(text, 2) - 1)
    local firstCharUpper = firstChar:upper()
    if firstChar == "ã" then firstCharUpper = "Ã" end
    letterPressed:set {
      content = {
        label = firstCharUpper
      }
    }
    verifyCorrectAnswer(firstCharUpper)
  end
end

return Level3
