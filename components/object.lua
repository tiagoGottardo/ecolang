local Rectangle = require "components.rectangle"
local Circle = require "components.circle"
local Square = require "components.square"

local Color = require "components.color"
local Position = require "components.position"

local Object = {}
Object.__index = Object

local function pickShape(shapeTable)
  shapeTable = shapeTable or {}
  shapeTable.kind = shapeTable.kind or 'rectangle'

  local shapes = {
    ['circle'] = function(t)
      return Circle:new(t)
    end,
    ['square'] = function(t)
      return Square:new(t)
    end,
    ['rectangle'] = function(t)
      return Rectangle:new(t)
    end
  }

  return shapes[shapeTable.kind](shapeTable)
end

function Object:new(objectTable)
  objectTable = objectTable or {}
  local instance = setmetatable({}, Object)
  instance.color = Color:new(objectTable.color)
  instance.position = Position:new(objectTable.position)
  instance.shape = pickShape(objectTable.shape)
  return instance
end

function Object:set(objectTable)
  objectTable = objectTable or {}
  self.color:set(objectTable.color)
  self.position:set(objectTable.position)
  self.shape:set(objectTable.shape)
end

function Object:draw()
  local r, g, b, a = self.color:format()
  self.shape:draw(r, g, b, a, self.position:get())
end

function Object:debug()
  print("Object(")
  self.shape:debug()
  self.color:debug()
  self.position:debug()
  print(")")
end

return Object
