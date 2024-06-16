local menu = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local Cursor = require 'src.cursor'
local simpleSlider = require "simple-slider"
local playBtn = {}
local header = {}
local title = {}
local playImage = {}
local titleImage = {}
local midW = 0;
local volumeSlider = {}
local sobreBtn
local placarBtn
local sairBtn

local utils = require 'utils'

local cursor = {}

local btnCollor = { 200, 200, 200 }

function menu.load()
  playBtn = Button:new({
    shape = {
      width = 300,
      height = 90.5,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Jogar',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40,
      position = {
        x = 100,
        y = 200
      }
    }

  })

  placarBtn = Button:new({
    shape = {
      width = 300,
      height = 53,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Placar',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40
    }

  })

  sobreBtn = Button:new({
    shape = {
      width = 300,
      height = 53,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Sobre',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40
    }

  })

  sairBtn = Button:new({
    shape = {
      width = 300,
      height = 53,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Sair',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40
    }

  })

  cursor = Cursor:new {
    botoes = { playBtn, sobreBtn, sairBtn }
  }

  playImage = Image:new({ name = "play.png", width = 60, height = 60 })
  titleImage = Image:new({ name = "titulo.png", width = 487, height = 225 })

  volumeSlider = newSlider(love.graphics.getWidth() - 50, love.graphics.getHeight() - 100, 300, 1, 0, 1,
    function(v) love.audio.setVolume(1) end,
    { width = 50, orientation = 'vertical', track = 'roundrect', knob = 'circle' })
  --screenshakeSlider = newSlider(400, 310, 300, screenshake, 0.5, 2, function (v) screenshake = v end, {width=20, orientation='horizontal', track='line', knob='rectangle'})

  menu.resize()
end

function menu.update(dt)
  -- Atualizar lógica
  volumeSlider:update()
end

function menu.draw()
  -- Desenhar elementos
  titleImage:draw(playBtn.position.x, 107.5)
  playBtn:draw()
  placarBtn:draw()
  sobreBtn:draw()
  sairBtn:draw()
  -- playImage:draw(playBtn.position.x, playBtn.position.y - 25)

  -- local r, g, b, a = love.graphics.getColor()
  -- love.graphics.setColor(love.math.colorFromBytes(36, 87, 197))
  -- volumeSlider:draw()
  -- love.graphics.setColor(r, g, b, a)
end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousepressed(x, y, button, istouch, presses)
  playBtn:onClick(x, y, button, (function()
    Game.currentLevel = 2
    Game.load()
  end))
  sobreBtn:onClick(x, y, button, (function()
    Game.currentLevel = 6
    Game.load()
  end))
  sairBtn:onClick(x, y, button, (function()
    love.event.quit()
  end))
  -- sobreBtn:onClick(x, y, button, (function()
  --   Game.currentLevel = 5
  --   Game.load()
  -- end))
end

function menu.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function menu.resize()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local mBtnH = sairBtn.shape.height

  midW = (windowWidth) / 2 --miniButtonHeigh

  playBtn.position.x = midW
  playBtn.position.y = windowHeight - (4 * mBtnH) - 60

  placarBtn.position.x = midW
  placarBtn.position.y = windowHeight - (3 * mBtnH) - 30

  sobreBtn.position.x = midW
  sobreBtn.position.y = windowHeight - (2 * mBtnH) - 20

  sairBtn.position.x = midW
  sairBtn.position.y = windowHeight - mBtnH - 10

  volumeSlider.x = windowWidth - volumeSlider.width
  volumeSlider.y = windowHeight - volumeSlider.length * 7 / 8
end

return menu
