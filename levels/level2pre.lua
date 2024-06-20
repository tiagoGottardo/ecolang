local Level2pre = {}
require("utils.colors")
local Object = require("components.object")
local Timer = require("src.timer")
local Button = require("components.button")
local Text = require("components.text")
local Image = require("components.image")
local Cursor = require 'src.cursor'
local cursor = {}

local container = {}
local centralContainer = require "levels.components.centralContainer"

local footer = {}
local componentFooter = require "levels.components.componentFooter"

local soundFooter = {}

local logo = {}
local titulo = {}
local helpButton = {}
local audioLabel = {}

function Level2pre.load()
  titulo = Button:new({
    position = { WINDOW_WIDTH / 2 - 300, 65 },
    shape = {
      width = 187.2,
      height = 50.1,
      radius = 30,
    },
    content = {
      kind = "text",
      label = "FASE 2:",
      fontSize = 40,
    },
    color = { 29, 159, 50 },
  })

  container = centralContainer:new("NESTA ATIVIDADE VOCÊ DEVERÁ RECONHECER A LETRA EM DESTAQUE E CLICAR SOBRE ELA EM SEU TECLADO:\n\n\n")

  footer = componentFooter:new()

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4 })
  audioLabel = love.audio.newSource("assets/sounds/fase2label.mp3", "static")

  cursor = Cursor:new {
    botoes = { footer.soundFooter, footer.proximoFooter }
  }
end

function Level2pre.mousepressed(x, y, button)
  footer.soundFooter:onClick(x, y, button, function()
    audioLabel:play()
  end)
  footer.proximoFooter:onClick(x, y, button, function()
    Game.currentLevel = 5
    Game.load()
  end)
end

function Level2pre.update(dt)
  -- Game.timer:update()
  -- if Game.timer:isTimeOver() and not evenTriggered then
  -- isTimeOverModal.hidden = false
  -- evenTriggered = true
  -- end
end

function Level2pre.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level2pre.draw()
  container:draw()
  titulo:draw()
  footer:draw()
  logo:draw(325 * 0.2, 152 * 0.2)
end

function Level2pre.keypressed(key) end

return Level2pre
