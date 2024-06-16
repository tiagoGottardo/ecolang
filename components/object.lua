local Rectangle = require "components.rectangle"
local Circle = require "components.circle"
local Square = require "components.square"

local Image = require "components.image"
local Text = require "components.text"
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

local function pickContent(contentTable)
  contentTable = contentTable or {}
  contentTable.kind = contentTable.kind or 'text'

  local contents = {
    ['image'] = function(t)
      return Image:new(t)
    end,
    ['text'] = function(t)
      return Text:new(t)
    end
  }

  return contents[contentTable.kind](contentTable)
end

function Object:new(objectTable)
  objectTable = objectTable or {}
  local instance = setmetatable({}, self)
  instance.color = Color:new(objectTable.color)
  instance.position = Position:new(objectTable.position)
  instance.shape = pickShape(objectTable.shape)
  instance.content = pickContent(objectTable.content)
  return instance
end

function Object:set(objectTable)
  objectTable = objectTable or {}
  self.content:set(objectTable.content)
  self.color:set(objectTable.color)
  self.position:set(objectTable.position)
  self.shape:set(objectTable.shape)
end

function Object:draw()
  local r, g, b, a = self.color:format()
  local size = self.shape:get()

  size.width = size.width or size.size or size.radius
  size.height = size.height or size.size or size.radius

  local position = self.position:get()
  self.shape:draw(r, g, b, a, position.x - size.width / 2, position.y - size.height / 2)
  if self.content.label ~= "" then
    self.content:draw(position.x, position.y)
  end
end

function Object:debug()
  print("Object(")
  self.shape:debug()
  self.color:debug()
  self.position:debug()
  self.content:debug()
  print(")")
end

return Object
