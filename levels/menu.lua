local menu = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local container = {}
local header = {}
local title = {}
local image = {}


function menu.load()
  -- Carregar recursos específicos
end

function menu.update(dt)
  -- Atualizar lógica
end

function menu.draw()
  -- Desenhar elementos
  
end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousepressed(x, y, button, is, touch, presses)
  btn:onPress { x = x, y = y, button = button, istouch = touch, press = presses }
end

function menu.mousereleased(x, y, button, istouch, presses)
  btn:onRelease { x = x, y = y, button = button, istouch = istouch, presses = presses }
end

return menu
