local Position = {}
Position.__index = Position

function Position:new(positionTable)
  positionTable = positionTable or {}
  local instance = setmetatable({}, Position)
  instance:set(positionTable)
  return instance
end

local function sanitizeValue(val, min)
  if type(min) ~= 'number' or type(val) ~= 'number' then
    return nil
  end

  return math.max(val, min)
end

function Position:set(positionTable)
  positionTable = positionTable or {}
  self.x = sanitizeValue(positionTable[1], 0) or self.x or 0
  self.y = sanitizeValue(positionTable[2], 0) or self.y or 0
end

function Position:get()
  return { self.x, self.y }
end

function Position:debug()
  print("   Position(" .. self.x .. ", " .. self.y .. ")")
end

return Position
