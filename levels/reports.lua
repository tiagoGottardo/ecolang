local Reports = {}

local Object = require 'components.object'
local Text = require 'components.text'
local Button = require 'components.button'
local reportModal = {}
local container, listContainer
local timeDefault = { init = 270, offSet = 40 }

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

local function textFactory(label)
  label = label or ""
  return Text:new({
    label = label,
    fontSize = 25,
    color = Black
  })
end

local someMockedItems = {
  { level = "Fase", try = "Tentativa",   correct = "Resposta" },
  { level = 1,      try = "GATO",        correct = "RATO" },
  { level = 2,      try = "RINOCERONTE", correct = "LOUVA-A-DEUS" },
  { level = 1,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
  { level = 1,      try = "GATO",        correct = "RATO" },
  { level = 3,      try = "GATO",        correct = "RATO" },
}

function Reports.load()
  center = { left = (WINDOW_WIDTH / 2) - 200, right = (WINDOW_WIDTH / 2) + 200 }

  errorsItems = someMockedItems
  errorsItem = Text:new({ fontSize = 16, color = Black })

  reportModal = Object:new({
    shape = {
      width = 800,
      height = 450,
      radius = 50
    },
    position = { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 }
  })
  reportModal.name = textFactory("Aluno:")
  reportModal.name:set({ fontSize = 40 })
  reportModal.nameValue = textFactory("Tiago")
  reportModal.nameValue:set({ fontSize = 40, color = Gray })


  reportModal.playedAt = {}
  reportModal.playedAt.date = textFactory("Data:")
  reportModal.playedAt.dateValue = textFactory("32/43/5439")
  reportModal.playedAt.dateValue:set({ color = Gray })

  reportModal.playedAt.time = textFactory("Horário:")
  reportModal.playedAt.timeValue = textFactory("23:57")
  reportModal.playedAt.timeValue:set({ color = Gray })

  reportModal.errorTitle = textFactory("Erros")
  reportModal.errorTitle:set({ fontSize = 35 })

  reportModal.timeTitle = textFactory("Tempo")
  reportModal.timeTitle:set({ fontSize = 30 })

  reportModal.lvl1Time = textFactory("Fase 1")
  reportModal.lvl1TimeValue = textFactory("5:43")
  reportModal.lvl1TimeValue:set({ color = Gray })

  reportModal.lvl2Time = textFactory("Fase 2")
  reportModal.lvl2TimeValue = textFactory("5:43")
  reportModal.lvl2TimeValue:set({ color = Gray })

  reportModal.lvl3Time = textFactory("Fase 3")
  reportModal.lvl3TimeValue = textFactory("5:43")
  reportModal.lvl3TimeValue:set({ color = Gray })

  reportModal.totalTime = textFactory("Total")
  reportModal.totalTimeValue = textFactory("5:43")
  reportModal.totalTimeValue:set({ color = Gray })

  reportModal.hidden = false

  listContainer = Object:new({
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
    position = { 160, 100 }
  })
end

function Reports.update(dt)
  errorsScrollOffset = math.max(0,
    math.min(errorsScrollOffset, #errorsItems * errorsItemHeight - errorsListHeight))
end

function Reports.draw()
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

    listContainer:draw()
    setBorder(love, listContainer)

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
  end
end

function Reports.wheelmoved(_, y)
  if not reportModal.hidden then
    errorsScrollOffset = errorsScrollOffset - y * errorsItemHeight
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
