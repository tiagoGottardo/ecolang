local Ranking = {}
local Text = require 'components.text'
local Object = require 'components.object'
local Button = require 'components.button'
local Image = require 'components.image'
local Cursor = require 'src.cursor'
local container, goHomeButton, listContainer
local logo, cursor, item
local database = require 'database.database'

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

local items = {}
local item = {}
local scrollOffset = 1
local itemHeight = 42
local itemsToShow = 10
local listWidth = 720
local listHeight = itemHeight * itemsToShow

function Ranking.load()
  items = database:getRanking()
  table.insert(items, 1, { name = "Nome", score = "Pontuação" })
  item = Text:new({ fontSize = 30, color = Black })
  container = Object:new({
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = 768,
      height = 471,
      radius = 50
    },
    content = {
      label = "Placar\n\n\n\n\n",
      color = Black,
      fontSize = 60,
    }
  })

  listContainer = Object:new({
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + 40 },
    shape = {
      width = 720,
      height = 350,
      radius = 30
    },
    color = LightGray
  })

  goHomeButton = Button:new({
    position = { WINDOW_WIDTH / 2 + 320, 95 },
    shape = {
      width = 88,
      height = 88,
      radius = 20,
    },
    content = {
      kind = "image",
      name = "home.png",
      width = 58,
      height = 58,
    },
    color = { a = 0 },
  })

  logo = Image:new({ name = "logo.png", width = 325 * 0.4, height = 152 * 0.4 })

  love.keyboard.setKeyRepeat(true)

  cursor = Cursor:new {
    botoes = { goHomeButton }
  }
end

function Ranking.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function Ranking.mousepressed(x, y, button)
  goHomeButton:onClick(x, y, button, function()
    Game.currentLevel = Game.instance == 'prof' and 12 or 1

    if Game.instance == 'prof' then
      Game.currentLevel = 12
    else
      Game.currentLevel = 1
    end
    Game.load()
  end)
end

function Ranking.update(dt)
  scrollOffset = math.max(0, math.min(scrollOffset, (#items - 7) * itemHeight))
end

function Ranking.draw()
  container:draw()
  setBorder(love, container)
  goHomeButton:draw()
  logo:draw(325 * 0.2, 152 * 0.2)

  listContainer:draw()
  setBorder(love, listContainer)

  love.graphics.setScissor((WINDOW_WIDTH - listWidth) / 2, (WINDOW_HEIGHT - listHeight) / 2 + 100, listWidth, listHeight)
  love.graphics.setColor(0, 0, 0, 1)
  for i = 1, #items do
    local y = i * itemHeight - scrollOffset + 150
    if y >= 50 - itemHeight and y <= 50 + listHeight then
      item:set({ label = items[i].name })
      item:draw(350, y + 3)
      item:set({ label = tostring(items[i].score) })
      love.graphics.rectangle("fill", (WINDOW_WIDTH - listWidth + 120) / 2, y + 23, 600, 2)
      item:draw(650, y + 3)
    end
  end
  love.graphics.setColor(1, 1, 1)
  love.graphics.setScissor()
end

function Ranking.wheelmoved(x, y)
  scrollOffset = scrollOffset - y * itemHeight
end

function Ranking.keypressed(key)
  if key == "down" then
    scrollOffset = scrollOffset + itemHeight
  elseif key == "up" then
    scrollOffset = scrollOffset - itemHeight
  end
end

return Ranking
