local Level2 = {}

local Timer = require 'src.timer'
local Text = require 'components.text'
local utils = require 'utils'
require 'utils.colors'

local titulo = nil
local timer = nil
local gameOver = nil

function Level2.load()
  titulo = love.graphics.newImage("assets/images/titulo.png")
  timer = Timer:new { color = Black }
  gameOver = Text:new { label = 'Game Over', color = Red }
  gameOver.color.a = 0

  timer:start(5)

  -- Carregar recursos específicos
end

function Level2.update(dt)
  -- Atualizar lógica
  -- if timer:isTimeOver() then
  --   gameOver.color.a=1
  --   timer.color.a=0
  -- else
  --   timer:update()
  -- end
end

function Level2.draw()
  love.graphics.draw(titulo, -25, -15, 0, 0.1, 0.1)

  love.graphics.print("Fase2", 400, 300)

  -- timer:draw(200, 200)
  -- gameOver:draw(200, 200)
end

function Level2.keypressed(key)
  -- Lidar com teclas pressionadas
end

return Level2
