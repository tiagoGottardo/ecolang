local Text = require 'components.text'
local Color = require 'components.color'

local Timer = setmetatable({}, { __index = Text })
Timer.__index = Timer

local function secondsToTimeFormat(sec)
  sec = type(sec) == 'number' and sec or 0
  return ('TEMPO: %02d:%02d'):format(math.floor(sec / 60), sec % 60)
end

function Timer:new(timerTable)
  timerTable = timerTable or {}
  local instance = setmetatable({}, Timer)
  instance.color = Color:new(timerTable.color)
  instance:set(timerTable)
  return instance
end

function Timer:set(timerTable)
  timerTable = timerTable or {}
  self.color:set(timerTable.color)
  self.timerDuration = 0
  self.timePassed = 0
  --self.startTime = nil
  self.wrapLimit = timerTable.wrapLimit or self.wrapLimit or 0
  self.label = timerTable.label or self.label or secondsToTimeFormat(self.timerDuration) or ""
  self.fontSize = timerTable.fontSize or self.fontSize or 24
end

function Timer:start(timerDuration)
  assert(type(timerDuration) == 'number', 'At Timer:start(timerDuration), "timerDuration" must be a number!')
  self.timerDuration = timerDuration + 1
  self.timePassed = 0
  --self.startTime = love.timer.getTime()
  self.label = secondsToTimeFormat(self.timerDuration) or ""
end

function Timer:update(dt)
  self.timePassed = self.timePassed + dt
  self.label = secondsToTimeFormat(math.max(self.timerDuration - self.timePassed, 0)) or ""
end

function Timer:isTimeOver()
  return self.timerDuration <= self.timePassed
end

return Timer
