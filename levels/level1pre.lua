local Level1pre = {}
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

function Level1pre.load()
  titulo = Button:new({
    position = { WINDOW_WIDTH / 2 - 300, 65 },
    shape = {
      width = 187.2,
      height = 50.1,
      radius = 30,
    },
    content = {
      kind = "text",
      label = "FASE 1:",
      fontSize = 40,
    },
    color = { 29, 159, 50 },
  })

  container = centralContainer:new("NESTA ATIVIDADE VOCÊ DEVERÁ LER E ASSOCIAR O NOME COM A SUA FIGURA CORRESPONDENTE:\n\n\n")

  footer = componentFooter:new()

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4 })
  audioLabel = love.audio.newSource("assets/sounds/fase1label.mp3", "static")

  cursor = Cursor:new {
    botoes = { footer.soundFooter, footer.proximoFooter }
  }
end

function Level1pre.mousepressed(x, y, button)
  footer.soundFooter:onClick(x, y, button, function()
    audioLabel:play()
  end)
  footer.proximoFooter:onClick(x, y, button, function()
    Game.currentLevel = 3
    Game.timer:start(600)
    Game.load()
  end)
end

function Level1pre.update(dt)
  --Game.timer:update()
  -- if Game.timer:isTimeOver() and not evenTriggered then
  -- isTimeOverModal.hidden = false
  -- evenTriggered = true
  -- end
end

function Level1pre.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level1pre.draw()
  container:draw()
  titulo:draw()
  footer:draw()
  logo:draw(325 * 0.2, 152 * 0.2)
end

function Level1pre.keypressed(key) end

return Level1pre
