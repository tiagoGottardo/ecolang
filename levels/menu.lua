local menu = {}
local Button = require 'src.button'
local utils = require 'src.utils'
--local btnA=Button:new()
--local btnB=Button:new{x=10,y=10}
--local btnC=Button:new()
local btn=Button:new{
  x=50,
  y=50,
  height=250,
  width=500,
  radius=50,
  state={
    cores={},
    contadorCores=1
  },
  onLoad=function(self)
    local state=self:getState()
    local cores={}
    for i=1,3 do
      cores[i]={}
      for j=1,3 do
        cores[i][j]=love.math.random()
      end
    end
    state.cores=cores
    local corAtual=state.cores[state.contadorCores]
    print(utils:tostring(state.cores), utils:tostring(corAtual))
    self:setColor(corAtual)
  end,
  onClick=function(self)
    local state=self:getState()
    state.contadorCores=1+state.contadorCores%#state.cores
    self:setColor(state.cores[state.contadorCores])
    print(utils:tostring(state.cores[state.contadorCores]))
  end
  }

function menu.load()
  -- Carregar recursos específicos
  btn:onLoad()
end

function menu.update(dt)
  -- Atualizar lógica
end

function menu.draw()
  -- Desenhar elementos
  if Button.isButton(btn) then
    btn:draw(love)
  end

  love.graphics.setColor{255,255,255,1}
  love.graphics.print("Menu", 400, 300)

end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousereleased( x, y, button, istouch, presses )
  print(('(%d,%d)'):format(x, y))
  if btn:isOver(x,y) then
    btn:onClick()
  end
end


return menu
