local Name = {}
local Text = require 'components.text'
local Object = require 'components.object'
local Button = require 'components.button'
local Image = require 'components.image'
local Cursor = require 'src.cursor'
local input, button, title, container, footer, soundFooter, titulo, proximoFooter
local logo, cursor, audioLabel, warning
local database = require 'database.database'

local containerTemplate = require 'levels.components.centralContainer'

local function setBorder(love, object)
  object = object or Object:new()
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(Black)
  love.graphics.rectangle(
    "line",
    object.position.x - object.shape.width / 2,
    object.position.y - object.shape.height / 2,
    object.shape.width,
    object.shape.height,
    object.shape.radius
  )
  love.graphics.setColor(r, g, b, a)
end

function Name.load()
  titulo = Button:new({
    position = { WINDOW_WIDTH / 2 - 300, 65 },
    shape = {
      width = 187.2,
      height = 50.1,
      radius = 30,
    },
    content = {
      kind = "text",
      label = "NOME",
      fontSize = 40,
    },
    color = { 29, 159, 50 },
  })

  container = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = 768,
      height = 471,
    },
  })
  container:set {
    content = {
      kind = "text",
      color = Black,
      fontSize = 40,
      label = "DIGITE SEU NOME:\n\n\n\n",
      wrapLimit = container.shape.width * 0.9
    }
  }

  footer = Object:new({
    color = LightGreen,
    position = { WINDOW_WIDTH / 2, 460 },
    shape = {
      width = 768,
      height = 108,
    },
  })

  footer.color:set({ a = 0.69 })

  soundFooter = Button:new({
    position = { WINDOW_WIDTH / 2 - 330, 460 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = "image",
      name = "sound.png",
      width = 58,
      height = 58,
    },
    color = { a = 0.51 },
  })

  proximoFooter = Button:new({
    position = { WINDOW_WIDTH / 2 + 330, 460 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = "image",
      name = "prox.png",
      width = 58,
      height = 58,
    },
    color = { a = 0.51 },
  })

  input = Object:new({
    content = { fontSize = 30, color = Black },
    shape = {
      width = 400,
      height = 50,
      radius = 25
    },
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + 30 }
  })

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4 })
  audioLabel = love.audio.newSource("assets/sounds/namelabel.mp3", "static")
  warning = love.audio.newSource("assets/sounds/warningname.mp3", "static")

  cursor = Cursor:new {
    botoes = { soundFooter, proximoFooter }
  }
  love.keyboard.setKeyRepeat(true)
end

function Name.mousepressed(x, y, button)
  soundFooter:onClick(x, y, button, function()
    audioLabel:play()
  end)
  proximoFooter:onClick(x, y, button, function()
    if input.content.label ~= "" then
      Game.play.name = input.content.label
      database:createPlay(Game.play)
      database:saveData()
      Game.currentLevel = Game.currentLevel + 1
      Game.load()
    else
      warning:play()
    end
  end)
end

function Name.update(dt)
  -- Se necessário, lógica de atualização pode ser colocada aqui
end

function Name.draw()
  container:draw()
  titulo:draw()
  input:draw()
  setBorder(love, input)
  footer:draw()
  soundFooter:draw()
  proximoFooter:draw()
end

function Name.keypressed(key)
  if key == "backspace" then
    input.content.label = input.content.label:sub(1, -2)
  elseif key == "return" then
    if input.content.label ~= "" then
      Game.play.name = input.content.label
      database:createPlay(Game.play)
      database:saveData()
      Game.currentLevel = Game.currentLevel + 1
      Game.load()
    else
      warning:play()
    end
  elseif key == "lshift" or key == "rshift" then
    return
  elseif key == "space" then
    input.content.label = input.content.label .. " "
  else
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
      if key:match("%a") then
        input.content.label = input.content.label .. key:upper()
      end
    else
      input.content.label = input.content.label .. key
    end
  end
end

return Name
