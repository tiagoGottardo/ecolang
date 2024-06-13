local sobre = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local voltarBtn = {}
local container = {}
local midW =0;

function sobre.load()
  container = Object:new {
    color=Gray,
    position={10,10},
    shape={ kind='rectangle' },
    content={
      kind='text',
      color=Black,
      label='SOBRE:\nO objetivo deste jogo prevê o aprendizado e melhoria na escrita dos alunos que o jogarem.\n\nFeito por: Thales Janisch Santos, Marcos Vinicius Passos, Claudiney Gustavo Rodrigues dos Santos, Natália Mendes Goes, Tiago Panizio Gottardo e Arthur Baldoqui Bergamo.\nRequisitos mínimos:\n- Processador: 1.6 GHz\n- Memória: 1GB RAM\n- Armazenamento: 40 MB de espaço livre'
    }
  }

  voltarBtn = Button:new({
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
      label = 'voltar',
      color = {36, 87, 197, 0.9},
      fontSize = 40,
      position ={
        x=100,
        y=200
      }
    }
    
  })

  sobre.resize()
end

function sobre.update(dt)
  -- Atualizar lógica
end

function sobre.draw()
  -- Desenhar elementos
  container:draw()
  voltarBtn:draw()
  
end

function sobre.keypressed(key)
  -- Lidar com teclas pressionadas
end

function sobre.mousepressed(x, y, button, is, touch, presses)
  if button == 1 then
    voltarBtn:onClick(x, y, (function(text)
      Game.currentLevel = 1
      Game.load()
    end), "tiago")
  end
end

function sobre.resize()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local mBtnH = sairBtn.shape.height

  midW = (windowWidth) / 2 --miniButtonHeigh

  voltarBtn.position.x = midW
  voltarBtn.position.y = windowHeight-(4*mBtnH)-137.5

  container:set {
    shape={
      width=windowWidth*0.8,
      height=windowHeight*0.8,
      radius=10
    },
    position={
      x=midW,
      y=windowHeight/2
    }
  }

end

return sobre
