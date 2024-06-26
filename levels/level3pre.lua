local Level3pre = {}
require("utils.colors")
local Object = require("components.object")
local Timer = require("src.timer")
local Button = require("components.button")
local Text = require("components.text")
local Image = require("components.image")
local Cursor = require 'src.cursor'
local cursor = {}
local container = {}
local footer = {}
local soundFooter = {}
local offsetOptionsV = 90
local offsetOptionsH = 160
local logo = {}
local titulo = {}
local helpButton = {}
local audioLabel = {}

function Level3pre.load()
  titulo = Button:new({
    position = { WINDOW_WIDTH / 2 - 300, 65 },
    shape = {
      width = 187.2,
      height = 50.1,
      radius = 30,
    },
    content = {
      kind = "text",
      label = "FASE 3:",
      fontSize = 40,
    },
    color = { 29, 159, 50 },
  })

  container = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = 768,
      height = 471,
    },
  })
  container:set {
    content = {
      kind = "text",
      color = Black,
      fontSize = 40,
      label = "NESTA ATIVIDADE VOCÊ DEVERÁ ESCREVER A PALAVRA CORRESPONDENTE A FIGURA UTILIZANDO O TECLADO:\n\n\n",
      wrapLimit = container.shape.width*0.9
    }
  }

  footer = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, 460 },
    shape = {
      width = 768,
      height = 108,
    },
  })

  footer.color:set({ a = 0.69 })

  soundFooter = Button:new({
    position = { WINDOW_WIDTH / 2 - 330, 460 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = "image",
      name = "sound.png",
      width = 58,
      height = 58,
    },
    color = { a = 0.51 },
  })

  proximoFooter = Button:new({
    position = { WINDOW_WIDTH / 2 + 330, 460 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = "image",
      name = "prox.png",
      width = 58,
      height = 58,
    },
    color = { a = 0.51 },
  })

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4 })
  audioLabel = love.audio.newSource("assets/sounds/fase3label.mp3", "static")

  cursor = Cursor:new {
    botoes = { soundFooter, proximoFooter }
  }
end

function Level3pre.mousepressed(x, y, button)
  soundFooter:onClick(x, y, button, function()
    audioLabel:play()
  end)
  proximoFooter:onClick(x, y, button, function()
    Game.currentLevel = 16
    Game.load()
  end)
end

function Level3pre.update(dt)
  --Game.timer:update()
  -- if Game.timer:isTimeOver() and not evenTriggered then
  -- isTimeOverModal.hidden = false
  -- evenTriggered = true
  -- end
end

function Level3pre.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level3pre.draw()
  container:draw()
  titulo:draw()
  footer:draw()
  soundFooter:draw()
  proximoFooter:draw()
  logo:draw(325 * 0.2, 152 * 0.2)
end

function Level3pre.keypressed(key) end

return Level3pre
