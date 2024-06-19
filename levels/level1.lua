local Level1 = {}
require("utils.colors")
local Object = require 'components.object'
local Timer = require 'src.timer'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local Cursor = require 'src.cursor'
local cursor = {}
local container = {}
local header = {}
local headerLabel = {}
local soundHeader = {}
local animalButtons = require "levels.components.animalButtons"
local options = {}
local logo = {}
local helpButton = {}
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
local failedModal
local isTimeOverModal
local evenTriggered = false

function Level1.load()
  evenTriggered = false
  correct = answers[math.floor(love.math.random() * 4) + 1]
  correctSound = love.audio.newSource("assets/sounds/" .. animalSound[correct] .. ".mp3", "static")

  options = animalButtons:new()
  container = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = 768,
      height = 471
    }
  })

  header = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, 97 },
    shape = {
      width = 768,
      height = 108
    }
  })
  header.color:set({ a = 0.69 })

  headerLabel = Object:new({
    position = { WINDOW_WIDTH / 2, 97 },
    shape = {
      width = 468,
      height = 88,
      radius = 20,
    },
    content = {
      label = correct,
      fontSize = 60,
      color = DarkGreen
    },
    color = { a = 0.51 }
  })
  soundHeader = Button:new({
    position = { WINDOW_WIDTH / 2 - 330, 97 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = 'image',
      name = 'sound.png',
      width = 58,
      height = 58
    },
    color = { a = 0.51 }
  })

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4, })
  helpButton = Button:new({
    shape = {
      width = 70,
      height = 70,
      radius = 20
    },
    content = {
      kind = 'image',
      name = 'question.png',
      width = 70,
      height = 70
    },
    position = { 960, 494 }
  })

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

  successModal = Object:new({
    shape = {
      width = 600,
      height = 300,
      radius = 20
    },
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
  })
  successModal:set({ color = { a = 1 } })
  successModal.text = Text:new({
    label = "PARABÉNS",
    fontSize = 40,
    color = Black
  })
  successModal.button = Button:new({
    shape = {
      width = 400,
      height = 75,
      radius = 40
    },
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + 50 },
    content = {
      label = "IR PARA A FASE 2",
      fontSize = 30,
      color = Black
    }
  })
  successModal.hidden = true

  failedModal = Object:new({
    shape = {
      width = 600,
      height = 300,
      radius = 20
    },
    color = Orange,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
  })
  failedModal.text = Text:new({
    label = "TENTE NOVAMENTE",
    fontSize = 40,
    color = Black
  })
  failedModal.button = Button:new({
    shape = {
      width = 400,
      height = 75,
      radius = 40
    },
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + 50 },
    content = {
      label = "JOGAR NOVAMENTE",
      fontSize = 30,
      color = Black
    }
  })
  failedModal.hidden = true

  cursor = Cursor:new {
    botoes = { options[1], options[2], options[3], options[4], soundHeader, helpButton }
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
  options[1]:onClick(x, y, button, verifyCorrectAnswer, options[1].value)
  options[2]:onClick(x, y, button, verifyCorrectAnswer, options[2].value)
  options[3]:onClick(x, y, button, verifyCorrectAnswer, options[3].value)
  options[4]:onClick(x, y, button, verifyCorrectAnswer, options[4].value)
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
  options:draw()
  Game.timer:draw(900, 20)
  logo:draw(325 * 0.2, 152 * 0.2)
  helpButton:draw()
  helpButton:setBorder()
  if not failedModal.hidden then
    failedModal:draw()
    failedModal:setBorder()
    failedModal.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
    failedModal.button:draw()
    failedModal.button:setBorder()
  end
  if not isTimeOverModal.hidden then
    isTimeOverModal:draw()
    isTimeOverModal:setBorder()
    isTimeOverModal.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
    isTimeOverModal.button:draw()
    isTimeOverModal.button:setBorder()
  end
  if not successModal.hidden then
    successModal:draw()
    successModal:setBorder()
    successModal.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
    successModal.button:draw()
    successModal.button:setBorder()
  end
end

function Level1.keypressed(key)
end

return Level1
