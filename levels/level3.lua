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

local animalSound
local animalImage

local successModal
local componentSucces = require "levels.components.componentSucces"

local failedModal
local componentFailed = require "levels.components.componentFailed"

local isTimeOverModal
local componentTimeOver = require "levels.components.componentTimeOver"

local evenTriggered = false
local inputContainer

local currentState

function Level3.load()
  evenTriggered = false
  animalSound = love.audio.newSource("assets/sounds/" .. Game.animal .. ".mp3", "static")

  currentState = {
    char=nil,
    start=nil,
    index=1,
    durationLimit=0.5
  }

  -- letterGoal = Object:new {
  --   color = { a = 0 },
  --   position = { WINDOW_WIDTH * 2 / 6, 97 },
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

  successModal = componentSucces:new("REGISTRAR PONTUAÇÃO")

  failedModal = componentFailed:new()
 
  inputContainer = Object:new {
    color = White,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = WINDOW_WIDTH * 2 / 3,
      height = 100,
      radius = 10
    },
    content = {
      color = Black,
      fontSize = 60,
      label = ''
    }
  }

  cursor = Cursor:new {
    botoes = { soundHeader, helpButton }
  }

  --print(utils.string:tostring(Game.animal))
  --for i, v in utf8.codes(Game.animal) do
  --  v=utf8.char(v)
  --  print(utils.string:tostring({i, v}))
  --end
end

local function verifyCorrectAnswer(answer)
  answer = answer or ""
  local needNextCode = false
  for i, v in utf8.codes(Game.animal) do
    v=utf8.char(v)
    if i==currentState.index then
      if v==currentState.char then
        currentState.char   = nil
        needNextCode = true
      else
        currentState.start  = love.timer.getTime()
      end
      if not needNextCode then
        break
      end
    elseif i>currentState.index then
      if needNextCode then
        currentState.index  = i
        needNextCode        = false
      end
      break
    end
  end
  if needNextCode then
    currentState.index=#Game.animal+1
  end
  if currentState.index==#Game.animal+1 then
    if Game.level3.currentRound >= Game.level3.totalRounds then
      successModal.hidden = false
      cursor:set { botoes = { successModal.button } }
    else
      Game.level3.next()
      Level3.load()
    end
  else
    --failedModal.hidden = false
    --cursor:set { botoes = { failedModal.button } }
  end
end

function Level3.mousepressed(x, y, button)
  -- print(utils.string:tostring{x, y})
  if (failedModal.hidden and successModal.hidden and isTimeOverModal.hidden) then
    soundHeader:onClick(x, y, button, (function() animalSound:play() end))
    helpButton:onClick(x, y, button, (function()
      Game.currentLevel = 16
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
      Game.currentLevel = 9
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
  if currentState.start and love.timer.getTime() - currentState.start >= currentState.durationLimit then
    currentState.char=nil
    currentState.start=nil
  end
  Game.timer:update(dt)
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
  inputContainer:draw()

  local myFont       = love.graphics.newFont("assets/Sniglet/Sniglet-Regular.ttf", 65)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(myFont)


  local highlightColor = { 0.8, 0, 0, 1 }
  local regularColor = { 0.027, 0.545, 0.141, 1 }
  local coloredText = { regularColor, Game.animal }
  local textWidth = 0
  local textHeight = myFont:getHeight()
  for i, v in ipairs(coloredText) do
    if i % 2 == 0 then
      textWidth = textWidth + myFont:getWidth(v)
    end
  end
  love.graphics.print(coloredText, myFont, WINDOW_WIDTH / 2 - textWidth / 2, 97 - textHeight / 2)

  local myFont       = love.graphics.newFont("assets/Sniglet/Sniglet-Regular.ttf", 60)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(myFont)


  local wrongColor = { 0.8, 0, 0, 1 }
  local correctColor = { 0, 0, 0, 0.4 }
  local regularColor = { 0, 0, 0, 1 }
  local coloredText = {}
  local textWidth = 0
  local textHeight = myFont:getHeight()

  for i, v in utf8.codes(Game.animal) do
    v=utf8.char(v)
    if i==currentState.index and currentState.char then
      if currentState.char==v then
        table.insert(coloredText, regularColor)
      else
        table.insert(coloredText, wrongColor)
      end
      table.insert(coloredText, currentState.char)
    else
      table.insert(coloredText, i<currentState.index and regularColor or correctColor)
      table.insert(coloredText, v)
    end
  end

  for i, v in ipairs(coloredText) do
    if i % 2 == 0 then
      textWidth = textWidth + myFont:getWidth(v)
    end
  end
  love.graphics.print(coloredText, myFont, WINDOW_WIDTH / 2 - textWidth / 2, WINDOW_HEIGHT / 2 - textHeight / 2)

  soundHeader:draw()
  animalImage:draw()
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

function Level3.textinput(text)
  if text then
    text=utils.string:upperUtf8(utils.string:firstUtf8Char(text))
    currentState.char   = text
    --print(utils.string:tostring(currentState))
    verifyCorrectAnswer(text)
  end
end

return Level3
