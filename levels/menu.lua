local menu = {}
local Button = require 'src.button'
--local btnA=Button:new()
--local btnB=Button:new{x=10,y=10}
--local btnC=Button:new()
local vermelho={255,0,0}
local azul={0,0,255}
local btn=Button:new{x=50, y=50, height=250, width=500, radius=50}

function menu.load()
  -- Carregar recursos específicos
  --btnA:setY(5)
  --btnC:setX(5)
  btn.ehVermelho=false
  btn:setColor(btn.ehVermelho and vermelho or azul)
end

function menu.update(dt)
  -- Atualizar lógica
end

function menu.draw()
  -- Desenhar elementos
  if Button.isButton(btn) then
    love.graphics.setColor(btn:getColor())
    love.graphics.rectangle('fill', btn:getX(), btn:getY(), btn:getWidth(), btn:getHeight(), btn:getRadius(), btn:getRadius())
  end

  love.graphics.setColor({255,255,255,1})
  love.graphics.print("Menu", 400, 300)
  --love.graphics.print(Button.isButton(btnA) and 'É botão' or 'Não é botão', 0, 0)
  --love.graphics.print(Button.isButton(2) and 'É botão' or 'Não é botão', 0, 10)
  --love.graphics.print(tostring(btnA:getX()), 0, 30)
  --love.graphics.print(tostring(btnB:getX()), 0, 40)
  --love.graphics.print(tostring(btnC:getX()), 0, 50)
  love.graphics.print(tostring(btn:getHeight()), 0, 10)

end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousereleased( x, y, button, istouch, presses )
  print(('(%d,%d)'):format(x, y))
  if btn:isOver(x, y) then
    print("Esta sobre o botao")
    btn.ehVermelho=not btn.ehVermelho
    btn:setColor(btn.ehVermelho and vermelho or azul)
    print(("Cor do botao: %s"):format(btn:getColor()[1]==vermelho[1] and "vermelho" or "azul"))
  else
    print("Nao esta sobre o botao")
  end
end


return menu
