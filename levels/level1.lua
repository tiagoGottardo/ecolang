local Level1 = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local container = {}
local header = {}
local title = {}
local image = {}

function Level1.load()
  container = Button:new({
    shape = {
      width = 300,
      height = 300,
      radius = 30
    },
    color = Red,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'Tiago',
      color = LightGreen,
      fontSize = 40
    }
  })
  title = Text:new({ label = "Titulo", fontSize = 30, color = DarkGreen })
  image = Image:new({ name = "logo.png", width = 300, height = 150 })
  header = Object:new({
    content = {
      kind = "image",
      name = "default.png",
    },
    color = Blue,
    position = {
      x = 400,
      y = 20
    }
  })
end

function Level1.mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    container:onClick(x, y, (function(text) print(text) end), "tiago")
  end
end

function Level1.update(dt)

end

function Level1.draw()
  container:draw()
  header:draw()
  title:draw(100, 100)
  image:draw(100, 400)
end

function Level1.keypressed(key)
  if key == 'q' then
    love.event.quit()
  end
end

return Level1
