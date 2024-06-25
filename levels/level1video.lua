local Level1video = {}
require("utils.colors")
local Object = require("components.object")
local Button = require("components.button")
local Text = require("components.text")
local Image = require("components.image")
local Cursor = require 'src.cursor'
local Video = require 'levels.components.componentVideo'
local cursor = {}
local container = {}
local offsetOptionsV = 90
local offsetOptionsH = 160
local logo = {}
local titulo = {}
local helpButton = {}
local video = {}

local utils = require 'utils'

function Level1video.load()
  container = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = 768,
      height = 471,
    },
  })

  video = Video:new { content = { name = 'level1.ogv' } }

  proximoFooter = Button:new({
    position = { 960, 494 },
    shape = {
      width = 70,
      height = 70,
      radius = 20,
    },
    content = {
      kind = "image",
      name = "prox.png",
      width = 58,
      height = 58,
    },
  })

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4 })

  cursor = Cursor:new {
    botoes = { proximoFooter, video.container }
  }

  video:play()
end

function Level1video.mousepressed(x, y, button)
  proximoFooter:onClick(x, y, button, function()
    video:stop()
    Game.currentLevel = 3
    Game.load()
  end)
  video:onClick(x, y, button)
end

function Level1video.update(dt)
  --Game.timer:update()
  -- if Game.timer:isTimeOver() and not evenTriggered then
  -- isTimeOverModal.hidden = false
  -- evenTriggered = true
  -- end
end

function Level1video.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Level1video.draw()
  container:draw()
  proximoFooter:draw()
  proximoFooter:setBorder()
  video:draw()
  video.container:setBorder()
  logo:draw(325 * 0.2, 152 * 0.2)
end

function Level1video.keypressed(key) end

return Level1video
