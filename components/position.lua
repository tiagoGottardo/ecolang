local Position = {}
Position.__index = Position

local t = require 'utils.input'

function Position:new(positionTable)
  positionTable = positionTable or {}
  local instance = setmetatable({}, Position)
  instance:set(positionTable)
  return instance
end

function Position:set(positionTable)
  positionTable = positionTable or {}
  self.x = t.sanitizeMin(positionTable.x or positionTable[1], 0) or self.x or 0
  self.y = t.sanitizeMin(positionTable.y or positionTable[2], 0) or self.y or 0
end

function Position:get()
  return { x = self.x, y = self.y }
end

function Position:debug()
  print("   Position(" .. self.x .. ", " .. self.y .. ")")
end

return Position
