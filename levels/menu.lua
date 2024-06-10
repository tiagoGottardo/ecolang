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
    isPressed=false,
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
    self:setColor(corAtual)
  end,
  onPress=function(self, mouse)
    local state=self:getState()
    print(utils:tostring(mouse))
    if self:isOver(mouse.x, mouse.y) then
      print('botão pressionado')
      state.isPressed=true
    end
  end,
  onRelease=function(self, mouse)
    local state=self:getState()
    print(utils:tostring(mouse))
    if state.isPressed and self:isOver(mouse.x, mouse.y) then
      print('botão solto')
      state.contadorCores=1+state.contadorCores%#state.cores
      self:setColor(state.cores[state.contadorCores])
    end
    state.isPressed=false
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

  love.graphics.setColor(1,1,1,1)
  love.graphics.print("Menu", 400, 300)

end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousepressed(x, y, button, is, touch, presses)
  btn:onPress{x=x, y=y, button=button, istouch=istouch, press=press}
end

function menu.mousereleased(x, y, button, istouch, presses)
  btn:onRelease{x=x, y=y, button=button, istouch=istouch, presses=presses}
end


return menu
