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
local footer = {}
local soundFooter = {}
local offsetOptionsV = 90
local offsetOptionsH = 160
local logo = {}
local titulo = {}
local helpButton = {}
local audioLabel = {}
local questStatement = {}

local function setBorder(love, object)
  object = object or Object:new()
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(Black)
  love.graphics.rectangle(
    "line",
    object.position.x - object.shape.width / 2,
    object.position.y - object.shape.height / 2,
    object.shape.width,
    object.shape.height,
    object.shape.radius
  )
  love.graphics.setColor(r, g, b, a)
end

function questStatement.load(levelName, levelStatement)
  titulo = Button:new({
    position = { WINDOW_WIDTH / 2 - 300, 65 },
    shape = {
      width = 187.2,
      height = 50.1,
      radius = 30,
    },
    content = {
      kind = "text",
      label = levelName,
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
      label = levelStatement,
      wrapLimit = container.shape.width * 0.9
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
  audioLabel = love.audio.newSource("assets/sounds/fase1label.mp3", "static")

  cursor = Cursor:new {
    botoes = { soundFooter, proximoFooter }
  }
end

function questStatement.mousepressed(x, y, button)
  soundFooter:onClick(x, y, button, function()
    audioLabel:play()
  end)
  proximoFooter:onClick(x, y, button, function()
    Game.currentLevel = 3
    Game.timer:start(600)
    Game.load()
  end)
end

function questStatement.update(dt)
  --Game.timer:update()
  -- if Game.timer:isTimeOver() and not evenTriggered then
  -- isTimeOverModal.hidden = false
  -- evenTriggered = true
  -- end
end

function questStatement.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function questStatement.draw()
  container:draw()
  titulo:draw()
  footer:draw()
  soundFooter:draw()
  proximoFooter:draw()
  logo:draw(325 * 0.2, 152 * 0.2)
end

function questStatement.keypressed(key) end

return Level1pre
