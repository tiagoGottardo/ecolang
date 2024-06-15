local Image = {}
Image.__index = Image

local imagesFilePath = 'assets/images/'
local t = require 'utils.input'

function Image:new(imageTable, getImageFn)
  imageTable = imageTable or {}
  local instance = setmetatable({}, Image)
  instance:set(imageTable, getImageFn)
  return instance
end

local function getImage(name)
  name = name or ""
  if name ~= "" then
    local success, result = pcall(function()
      return love.graphics.newImage(imagesFilePath .. name)
    end)

    if success then
      return result
    else
      print("Erro ao carregar a imagem: " .. result)
      return love.graphics.newImage(imagesFilePath .. "default.png")
    end
  end
end

function Image:set(imageTable, getImageFn)
  getImageFn = getImageFn or getImage
  imageTable = imageTable or {}
  self.name = imageTable.name or self.name or "default.png"
  self.width = t.sanitizeMin(imageTable.width, 0) or self.width or 200
  self.height = t.sanitizeMin(imageTable.height, 0) or self.height or 200
  self.image = getImageFn(self.name)
end

function Image:draw(X, Y)
  local originalWidth = self.image:getWidth()
  local originalHeight = self.image:getHeight()

  local sx = self.width / originalWidth
  local sy = self.height / originalHeight

  love.graphics.draw(self.image, X - self.width / 2, Y - self.height / 2, 0, sx, sy)
end

function Image:debug()
  print("   Image(" .. self.name .. ", " .. self.width .. "X" .. self.height .. ")")
end

return Image
