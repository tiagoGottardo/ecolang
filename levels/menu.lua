local menu = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local playBtn = {}
local header = {}
local title = {}
local playImage = {}
local titleImage = {}
local midW =0;

function menu.load()
  playBtn = Button:new({
    shape = {
      width = 560,
      height = 150,
      radius = 30
    },
    color = Gray,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Jogar',
      color = {36, 87, 197, 0.9},
      fontSize = 40,
      position ={
        x=100,
        y=200
      }
    }
    
  })

  placarBtn = Button:new({
    shape = {
      width = 560,
      height = 75,
      radius = 30
    },
    color = Gray,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Placar',
      color = {36, 87, 197, 0.9},
      fontSize = 40
    }
    
  })

  sobreBtn = Button:new({
    shape = {
      width = 560,
      height = 75,
      radius = 30
    },
    color = Gray,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Sobre',
      color = {36, 87, 197, 0.9},
      fontSize = 40
    }
    
  })

  sairBtn = Button:new({
    shape = {
      width = 560,
      height = 75,
      radius = 30
    },
    color = Gray,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Sair',
      color = {36, 87, 197, 0.9},
      fontSize = 40
    }
    
  })

  playImage = Image:new({ name = "play.png", width = 60, height = 60 })
  titleImage = Image:new({ name = "titulo.png", width = 455, height = 215 })

  menu.resize()
end

function menu.update(dt)
  -- Atualizar lógica
end

function menu.draw()
  -- Desenhar elementos
  titleImage:draw(playBtn.position.x,107.5)
  playBtn:draw()
  placarBtn:draw()
  sobreBtn:draw()
  sairBtn:draw()
  playImage:draw(playBtn.position.x, playBtn.position.y-25)
  
end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousepressed(x, y, button, is, touch, presses)
  if button == 1 then
    playBtn:onClick(x, y, (function(text)
      Game.currentLevel = 2
      Game.load()
    end), "tiago")
  end
end

function menu.resize()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local mBtnH = sairBtn.shape.height

  midW = (windowWidth) / 2 --miniButtonHeigh

  playBtn.position.x = midW
  playBtn.position.y = windowHeight-(4*mBtnH)-137.5

  placarBtn.position.x = midW
  placarBtn.position.y = windowHeight-(3*mBtnH)-75

  sobreBtn.position.x = midW
  sobreBtn.position.y = windowHeight-(2*mBtnH)-50

  sairBtn.position.x = midW
  sairBtn.position.y = windowHeight-mBtnH-25

end

return menu
