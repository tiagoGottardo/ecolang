local Video = {}
Video.__index = Video

local videosFilePath = 'assets/videos/'
local t = require 'utils.input'

function Video:new(videoTable, getVideoFn)
  videoTable = videoTable or {}
  local instance = setmetatable({}, Video)
  instance:set(videoTable, getVideoFn)
  return instance
end

local function getVideo(name)
  name = name or ""
  if name ~= "" then
    local success, result = pcall(function()
      return love.graphics.newVideo(videosFilePath .. name)
    end)

    if success then
      return result
    else
      print("Erro ao carregar o vídeo: " .. result)
      return love.graphics.newVideo(videosFilePath .. "default.ogv")
    end
  end
end

function Video:set(videoTable, getVideoFn)
  getVideoFn = getVideoFn or getVideo
  videoTable = videoTable or {}
  self.name = videoTable.name or self.name or "default.ogv"
  self.width = t.sanitizeMin(videoTable.width, 0) or self.width or 200
  self.height = t.sanitizeMin(videoTable.height, 0) or self.height or 200
  self.video = getVideoFn(self.name)
end

function Video:draw(X, Y)
  local originalWidth = self.video:getWidth()
  local originalHeight = self.video:getHeight()

  local sx = self.width / originalWidth
  local sy = self.height / originalHeight

  love.graphics.draw(self.video, X - self.width / 2, Y - self.height / 2, 0, sx, sy)
end

function Video:debug()
  print("   Video(" .. self.name .. ", " .. self.width .. "X" .. self.height .. ")")
end

return Video
