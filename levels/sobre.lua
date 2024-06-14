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

local cursor={}

local function setBorder(love, object)
  object = object or Object:new()
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(Black)
  love.graphics.rectangle("line", object.position.x - object.shape.width / 2,
    object.position.y - object.shape.height / 2, object.shape.width, object.shape.height,
    object.shape.radius)
  love.graphics.setColor(r, g, b, a)
end

function sobre.load()
  container = Object:new {
    color = containerColor,
    position = { 10, 10 },
    shape = { kind = 'rectangle' },
    content = {
      kind = 'text',
      color = Black,
      label = 'SOBRE:\nO objetivo deste jogo prevê o aprendizado e melhoria na escrita dos alunos que o jogarem.\n\nFeito por: Thales Janisch Santos, Marcos Vinicius Passos, Claudiney Gustavo Rodrigues dos Santos, Natália Mendes Goes, Tiago Panizio Gottardo e Arthur Baldoqui Bergamo.\nRequisitos mínimos:\n- Processador: 1.6 GHz\n- Memória: 1GB RAM\n- Armazenamento: 40 MB de espaço livre'
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
      label = 'Voltar',
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
  setBorder(love, container)
  voltarBtn:draw()
  --setBorder(love, voltarBtn)
end

function sobre.keypressed(key)
  -- Lidar com teclas pressionadas
end

function sobre.mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    voltarBtn:onClick(x, y, button, (function()
      Game.currentLevel = 1
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
      x = windowWidth * 0.75,
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
