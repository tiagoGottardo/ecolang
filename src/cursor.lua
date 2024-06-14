local Cursor = {}
Cursor.__index = Cursor

function Cursor:new(cursorTable)
  cursorTable = cursorTable or {}
  local instance = setmetatable({}, Cursor)
  instance:set(cursorTable)
  return instance
end

function Cursor:set(cursorTable)
  cursorTable = cursorTable or {}
  self.botoes = cursorTable.botoes or {}
  self.cursorClicavel = cursorTable.cursorClicavel or love.mouse.getSystemCursor('hand')
  self.cursorPadrao = cursorTable.cursorClica or love.mouse.getSystemCursor('arrow')
  self.estadoAnterior=nil
end

function Cursor:addBtn(btn)
  for _,b in ipairs(self.botoes) do
    if b==btn then
      return
    end
  end
  table.insert(self.botoes, btn)
end

function Cursor:removeBtn(btn)
  local index=0
  for i,b in ipairs(self.botoes) do
    if b==btn then
      index=i
      break
    end
  end
  if index>0 then
    table.remove(self.botoes, index)
  end
end

function Cursor:update(x, y)
  local sobreBotao=false
  for _,btn in ipairs(self.botoes) do
    if btn:isHover(x, y) then
      sobreBotao=true
      break
    end
  end
  if self.estadoAnterior~=sobreBotao then
    local cursor = sobreBotao and self.cursorClicavel or self.cursorPadrao
    self.estadoAnterior=sobreBotao
    love.mouse.setCursor(cursor)
  end
end

return Cursor
