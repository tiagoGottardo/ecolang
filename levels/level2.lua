local Level2 = {}
require("utils.colors")
local utils = require 'utils'
local utf8 = require 'utf8'
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
local options = {}
local offsetOptionsV = 90
local offsetOptionsH = 160
local logo = {}
local helpButton = {}
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
local failedModal
local isTimeOverModal
local evenTriggered = false
local letterPressed
local letterGoal

local function setBorder(love, object)
  object = object or Object:new()
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(Black)
  love.graphics.rectangle("line", object.position.x - object.shape.width / 2,
    object.position.y - object.shape.height / 2, object.shape.width, object.shape.height,
    object.shape.radius)
  love.graphics.setColor(r, g, b, a)
end


function Level2.load()
  evenTriggered = false
  animal = animals[math.floor(love.math.random() * 4) + 1]
  animalSound = love.audio.newSource("assets/sounds/" .. animalsSounds[animal], "static")

  letterPressed = Object:new {
    color = LightGray,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
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
      label = animal,
      fontSize = 60,
      color = DarkGreen
    },
    color = { a = 0.51 }
  })
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
      label = "IR PARA O MENU",
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
    botoes = { soundHeader, helpButton }
  }
end

local function verifyCorrectAnswer(answer)
  answer = answer or ""
  if animal == answer then
    successModal.hidden = false
    cursor:set { botoes = { successModal.button } }
  else
    failedModal.hidden = false
    cursor:set { botoes = { failedModal.button } }
  end
end

function Level2.mousepressed(x, y, button)
  soundHeader:onClick(x, y, button, (function() animalSound:play() end))
  helpButton:onClick(x, y, button, (function()
    Game.currentLevel = 4
    Game.load()
  end))
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

function Level2.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level2.update(dt)
  Game.timer:update()
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
  soundHeader:draw()
  animalImage:draw()
  Game.timer:draw(900, 20)
  logo:draw(325 * 0.2, 152 * 0.2)
  letterPressed:draw()
  helpButton:draw()
  setBorder(love, helpButton)
  if not failedModal.hidden then
    failedModal:draw()
    setBorder(love, failedModal)
    failedModal.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
    failedModal.button:draw()
    setBorder(love, failedModal.button)
  end
  if not isTimeOverModal.hidden then
    isTimeOverModal:draw()
    setBorder(love, isTimeOverModal)
    isTimeOverModal.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
    isTimeOverModal.button:draw()
    setBorder(love, isTimeOverModal.button)
  end
  if not successModal.hidden then
    successModal:draw()
    setBorder(love, successModal)
    successModal.text:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 40)
    successModal.button:draw()
    setBorder(love, successModal.button)
  end
end

function Level2.textinput(text)
  if text then
    text=text:upper()
    letterPressed:set {
      content = {
        label = text
      }
    }
  end
end

return Level2
