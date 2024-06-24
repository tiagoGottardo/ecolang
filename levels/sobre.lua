local sobre = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local Cursor = require 'src.cursor'

local voltarBtn = {}
local container = {}
local midW = 0;

local btnCollor = { 200, 200, 200 }
local containerColor = { 250, 250, 250 }

local cursor = {}

function sobre.load()
  container = Object:new {
    color = containerColor,
    position = { 10, 10 },
    shape = { kind = 'rectangle' },
    content = {
      kind = 'text',
      color = Black,
      label = 'SOBRE:\nO OBJETIVO DESTE JOGO PREVÊ O APRENDIZADO E MELHORIA NA ESCRITA DOS ALUNOS QUE O JOGAREM \n\nFEITO POR: ARTHUR BALDOQUI BERGAMO, CLAUDINEY GUSTAVO RODRIGUES DOS SANTOS, MARCOS VINICIUS PASSOS, NATÁLIA MENDES GOES, THALES JANISCH SANTOS E TIAGO PANIZIO GOTTARDO.\nREQUISITOS MÍNIMOS:\n- PROCESSADOR: 1.6 GHZ\n- MEMÓRIA: 1GB RAM\n- ARMAZENAMENTO: 40 MB DE ESPAÇO LIVRE'
    }
  }

  voltarBtn = Button:new({
    shape = {
      width = 560,
      height = 150,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'VOLTAR',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40,
      position = {
        x = 100,
        y = 200
      }
    }

  })

  cursor = Cursor:new {
    botoes = {
      voltarBtn
    }
  }

  sobre.resize()
end

function sobre.update(dt)
  -- Atualizar lógica
end

function sobre.draw()
  -- Desenhar elementos
  container:draw()
  container:setBorder()
  voltarBtn:draw()
  --setBorder(love, voltarBtn)
end

function sobre.keypressed(key)
  -- Lidar com teclas pressionadas
end

function sobre.mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    voltarBtn:onClick(x, y, button, (function()
      Game.currentLevel = Game.instance == 'prof' and 12 or 1
      Game.load()
    end))
  end
end

function sobre.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function sobre.resize()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  -- local mBtnH = sairBtn.shape.height

  midW = (windowWidth) / 2 --miniButtonHeigh

  voltarBtn:set {
    shape = {
      width = windowWidth * 0.2,
      height = windowWidth * 0.1
    },
    position = {
      x = windowWidth * 0.77,
      y = windowHeight * 0.8
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

return sobre
