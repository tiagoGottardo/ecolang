local Reports = {}

local t = require 'utils.table'

local function secondsToTimeFormat(sec)
  sec = type(sec) == 'number' and sec or 0
  return ('%02d:%02d'):format(math.floor(sec / 60), sec % 60)
end

local Object = require 'components.object'
local Text = require 'components.text'
local Image = require 'components.image'
local Button = require 'components.button'
local reportModal = {}
local timeDefault = { init = 270, offSet = 40 }
local container, goHomeButton, listContainer, containerModal
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

local center = {}
local errorsItem = {}
local errorsItems = {}
local errorsScrollOffset = 1
local errorsItemHeight = 42
local errorsItemsToShow = 10
local errorsListWidth = 320
local errorsListHeight = errorsItemHeight * errorsItemsToShow

local items
local scrollOffset = 1
local itemHeight = 42
local itemsToShow = 10
local listWidth = 720
local listHeight = itemHeight * itemsToShow

local function textFactory(label)
  label = label or ""
  return Text:new({
    label = label,
    fontSize = 25,
    color = Black
  })
end


function Reports.load()
  center = { left = (WINDOW_WIDTH / 2) - 200, right = (WINDOW_WIDTH / 2) + 200 }

  errorsItems = t:deepCopy(Game.report.errors)
  table.insert(errorsItems, 1, { level = "Fase", try = "Tentativa", correct = "Resposta" })

  errorsItem = Text:new({ fontSize = 16, color = Black })

  reportModal = Object:new({
    shape = {
      width = 768,
      height = 471,
      radius = 50
    },
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 }
  })
  reportModal.name = textFactory("Aluno:")
  reportModal.name:set({ fontSize = 40 })
  reportModal.nameValue = textFactory(Game.report.name or "")
  reportModal.nameValue:set({ fontSize = 40, color = Gray })


  reportModal.playedAt = {}
  reportModal.playedAt.date = textFactory("Data:")
  reportModal.playedAt.dateValue = textFactory(Game.report.playedAt.date or "--/--/----")
  reportModal.playedAt.dateValue:set({ color = Gray })

  reportModal.playedAt.time = textFactory("Horário:")
  reportModal.playedAt.timeValue = textFactory(Game.report.playedAt.time or "--:--")
  reportModal.playedAt.timeValue:set({ color = Gray })

  reportModal.errorTitle = textFactory("Erros")
  reportModal.errorTitle:set({ fontSize = 35 })

  reportModal.timeTitle = textFactory("Tempo")
  reportModal.timeTitle:set({ fontSize = 30 })

  reportModal.lvl1Time = textFactory("Fase 1")
  reportModal.lvl1TimeValue = textFactory(secondsToTimeFormat(Game.report.lvl1.time) or "00:00")
  reportModal.lvl1TimeValue:set({ color = Gray })

  reportModal.lvl2Time = textFactory("Fase 2")
  reportModal.lvl2TimeValue = textFactory(secondsToTimeFormat(Game.report.lvl2.time) or "00:00")
  reportModal.lvl2TimeValue:set({ color = Gray })

  reportModal.lvl3Time = textFactory("Fase 3")
  reportModal.lvl3TimeValue = textFactory(secondsToTimeFormat(Game.report.lvl3.time) or "00:00")
  reportModal.lvl3TimeValue:set({ color = Gray })

  reportModal.totalTime = textFactory("Total")
  reportModal.totalTimeValue = textFactory(secondsToTimeFormat((Game.report.lvl1.time or
      0) + (Game.report.lvl2.time or 0) +
    (Game.report.lvl3.time or 0)) or "00:00")
  reportModal.totalTimeValue:set({ color = Gray })

  reportModal.hidden = true

  containerModal = Object:new({
    position = { (WINDOW_WIDTH / 2) + 200, (WINDOW_HEIGHT / 2) + 18 },
    shape = {
      width = 320,
      height = 350,
      radius = 10
    },
    color = LightGray
  })

  reportModal.closeButton = Button:new({
    shape = {
      width = 40,
      height = 40,
      radius = 20
    },
    content = {
      label = "X",
      color = Black,
      fontSize = 22
    },
    color = LightRed,
    position = { 185, 100 }
  })

  items = database:getReports()
  table.insert(items, 1, { name = "Nome", score = "Data" })

  for i, v in ipairs(items) do
    v.nameBtn = Button:new({
      color = { a = 0 },
      shape = {
        width = 400, height = 40
      },
      content = {
        label = v.name,
        fontSize = 30,
        color = Black
      }
    })

    v.scoreBtn = Button:new({
      color = { a = 0 },
      shape = {
        width = 400, height = 40
      },
      content = {
        label = tostring(v.score),
        fontSize = 30,
        color = Black
      }
    })
  end

  container = Object:new({
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
    shape = {
      width = 768,
      height = 471,
      radius = 50
    },
    content = {
      label = "Relatórios\n\n\n\n\n",
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
end

function Reports.update(dt)
  errorsScrollOffset = math.max(0,
    math.min(errorsScrollOffset, #errorsItems * errorsItemHeight - errorsListHeight))

  scrollOffset = math.max(0,
    math.min(scrollOffset, #items * itemHeight - listHeight))
end

function Reports.draw()
  container:draw()
  setBorder(love, container)
  goHomeButton:draw()
  logo:draw(325 * 0.2, 152 * 0.2)

  listContainer:draw()
  setBorder(love, listContainer)

  love.graphics.setScissor((WINDOW_WIDTH - listWidth) / 2, (WINDOW_HEIGHT - listHeight) / 2 + 100, listWidth, listHeight)
  love.graphics.setColor(0, 0, 0, 1)
  for i = #items, 1, -1 do
    local y = i * itemHeight - scrollOffset + 150
    if y >= 50 - itemHeight and y <= 50 + listHeight then
      items[i].nameBtn:set({ position = { 350, y + 3 } })
      items[i].scoreBtn:set({ position = { 650, y + 3 } })
      items[i].nameBtn:draw()
      items[i].scoreBtn:draw()
      love.graphics.rectangle("fill", (WINDOW_WIDTH - listWidth + 120) / 2, y + 23, 600, 2)
    end
  end
  love.graphics.setColor(1, 1, 1)
  love.graphics.setScissor()

  if not reportModal.hidden then
    reportModal:draw()
    setBorder(love, reportModal)

    reportModal.name:draw(center.left - 80, 180)
    reportModal.nameValue:draw(center.left + 80, 180)

    reportModal.playedAt.date:draw(center.left + 45, 325)
    reportModal.playedAt.dateValue:draw(center.left + 150, 325)

    reportModal.playedAt.time:draw(center.left + 60, 365)
    reportModal.playedAt.timeValue:draw(center.left + 180, 365)

    reportModal.timeTitle:draw(center.left - 80, timeDefault.init - 10)
    reportModal.lvl1Time:draw(center.left - 120, timeDefault.init + timeDefault.offSet)
    reportModal.lvl1TimeValue:draw(center.left - 40, timeDefault.init + timeDefault.offSet)

    reportModal.lvl2Time:draw(center.left - 120, timeDefault.init + 2 * timeDefault.offSet)
    reportModal.lvl2TimeValue:draw(center.left - 40, timeDefault.init + 2 * timeDefault.offSet)

    reportModal.lvl3Time:draw(center.left - 120, timeDefault.init + 3 * timeDefault.offSet)
    reportModal.lvl3TimeValue:draw(center.left - 40, timeDefault.init + 3 * timeDefault.offSet)

    reportModal.totalTime:draw(center.left - 120, timeDefault.init + 4 * timeDefault.offSet)
    reportModal.totalTimeValue:draw(center.left - 40, timeDefault.init + 4 * timeDefault.offSet)

    reportModal.errorTitle:draw(center.right, 90)

    containerModal:draw()
    setBorder(love, containerModal)

    love.graphics.setScissor(((WINDOW_WIDTH - errorsListWidth) / 2) + 200,
      ((WINDOW_HEIGHT - errorsListHeight) / 2) + 70,
      errorsListWidth,
      errorsListHeight)
    love.graphics.setColor(0, 0, 0, 1)
    for i = 1, #errorsItems do
      local y = i * errorsItemHeight - errorsScrollOffset + 103
      if y >= 50 - errorsItemHeight and y <= 50 + errorsListHeight then
        errorsItem:set({ label = tostring(errorsItems[i].level) })
        errorsItem:draw((WINDOW_WIDTH / 2) + 75, y + 3)

        errorsItem:set({ label = errorsItems[i].try })
        errorsItem:draw((WINDOW_WIDTH / 2) + 165, y + 3)

        errorsItem:set({ label = errorsItems[i].correct })
        errorsItem:draw((WINDOW_WIDTH / 2) + 285, y + 3)

        love.graphics.rectangle("fill", center.right - 150, y + 23, 300, 2)
      end
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.setScissor()

    reportModal.closeButton:draw()
    setBorder(love, reportModal.closeButton)
  end
end

function Reports.mousepressed(x, y, button)
  if not reportModal.hidden then
    reportModal.closeButton:onClick(x, y, button, (function()
      reportModal.hidden = true
    end))
  else
    for i, v in ipairs(items) do
      items[i].nameBtn:onClick(x, y, button, function()
        if i ~= 1 then
          Game.report = database:getReport(i - 1)
          Game.load()
          reportModal.hidden = false
        end
      end)
      items[i].scoreBtn:onClick(x, y, button, function()
        if i ~= 1 then
          Game.report = database:getReport(i - 1)
          Game.load()
          reportModal.hidden = false
        end
      end)
    end
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
end

function Reports.wheelmoved(_, y)
  if not reportModal.hidden then
    errorsScrollOffset = errorsScrollOffset - y * errorsItemHeight
  else
    scrollOffset = scrollOffset - y * itemHeight
  end
end

function Reports.keypressed(key)
  if not reportModal.hidden then
    if key == "down" then
      errorsScrollOffset = errorsScrollOffset + errorsItemHeight
    elseif key == "up" then
      errorsScrollOffset = errorsScrollOffset - errorsItemHeight
    end
  end
end

return Reports
