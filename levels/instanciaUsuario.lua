local instancia = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Cursor = require 'src.cursor'

local alunoBtn = {}
local profBtn = {}
local container = {}

local btnCollor = { 200, 200, 200 }
local containerColor = { 250, 250, 250 }

local cursor={}

function instancia.load()
  container = Object:new {
    color = containerColor,
    position = { 10, 10 },
    shape = { kind = 'rectangle' },
    content = {
      kind = 'text',
      fontSize = 50,
      color = Black,
      label = 'ALUNO OU PROFESSOR?\n\n\n\n\n\n'
    }
  }

  alunoBtn = Button:new({
    shape = {
      width = 560,
      height = 150,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 200,
      y = 150
    },
    content = {
      label = 'ALUNO',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40,
      position = {
        x = 10,
        y = 200
      }
    }

  })

  profBtn = Button:new({
    shape = {
      width = 560,
      height = 150,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 100,
      y = 300
    },
    content = {
      label = 'PROFESSOR',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40,
      position = {
        x = 100,
        y = 200
      }
    }

  })

  cursor = Cursor:new {
    botoes={
      alunoBtn, profBtn
    }
  }

  instancia.resize()
end

function instancia.update(dt)
  -- Atualizar lógica
end

function instancia.draw()
  -- Desenhar elementos
  container:draw()
  container:setBorder()
  alunoBtn:draw()
  profBtn:draw()
  --setBorder(love, alunoBtn)
end

function instancia.keypressed(key)
  -- Lidar com teclas pressionadas
end

function instancia.mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    alunoBtn:onClick(x, y, button, (function()
      Game.currentLevel = 1
      Game.load()
    end))
    profBtn:onClick(x, y, button, (function()
      Game.currentLevel = 10
      Game.load()
    end))
  end
end

function instancia.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function instancia.resize()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  -- local mBtnH = sairBtn.shape.height

  midW = (windowWidth) / 2 --miniButtonHeigh

  alunoBtn:set {
    shape = {
      width = windowWidth * 0.2,
      height = windowWidth * 0.2
    },
    position = {
      x = windowWidth * 0.23,
      y = windowHeight * 0.5
    }
  }

  profBtn:set {
    shape = {
      width = windowWidth * 0.25,
      height = windowWidth * 0.2
    },
    position = {
      x = windowWidth * 0.74,
      y = windowHeight * 0.5
    }
  }

  local containerTable = {}
  containerTable.shape = {
    width = windowWidth * 0.8,
    height = windowHeight * 0.8,
    radius = 10
  }
  containerTable.position = {
    x = midW,
    y = windowHeight / 2
  }
  containerTable.content = {
    wrapLimit = containerTable.shape.width * 0.8
  }

  container:set(containerTable)
end

return instancia
