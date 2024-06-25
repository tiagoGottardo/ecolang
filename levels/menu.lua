local menu = {}
require("utils.colors")
local Object = require 'components.object'
local Button = require "components.button"
local Text = require "components.text"
local Image = require "components.image"
local Cursor = require 'src.cursor'
local simpleSlider = require "simple-slider"
local playBtn = {}
local header = {}
local title = {}
local playImage = {}
local titleImage = {}
local midW = 0;
local volumeSlider = {}
local sobreBtn
local placarBtn
local sairBtn

local componentSoundHeader = require "levels.components.componentSoundHeader"
local soundHeaders = {
  play = {},
  placar = {},
  sobre = {},
  sair = {}
}

local utils = require 'utils'
local animalsIndex = utils.animals

local cursor = {}

local btnCollor = { 200, 200, 200 }

function menu.load()
  playBtn = Button:new({
    shape = {
      width = 300,
      height = 90.5,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'JOGAR',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40,
      position = {
        x = 100,
        y = 200
      }
    }

  })

  placarBtn = Button:new({
    shape = {
      width = 300,
      height = 53,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'PLACAR',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40
    }

  })

  sobreBtn = Button:new({
    shape = {
      width = 300,
      height = 53,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'SOBRE',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40
    }

  })

  sairBtn = Button:new({
    shape = {
      width = 300,
      height = 53,
      radius = 30
    },
    color = btnCollor,
    position = {
      x = 400,
      y = 300
    },
    content = {
      label = 'SAIR',
      color = { 36, 87, 197, 0.9 },
      fontSize = 40
    }

  })

  soundHeaders.play = componentSoundHeader:new()
  soundHeaders.placar = componentSoundHeader:new()
  soundHeaders.sobre = componentSoundHeader:new()
  soundHeaders.sair = componentSoundHeader:new()
  soundHeaders.play:set {
    shape = {
      width = 70,
      height = 70
    }
  }
  soundHeaders.play.sound = love.audio.newSource('assets/sounds/play.mp3', 'static')
  soundHeaders.placar:set {
    shape = {
      width = 60,
      height = 60
    }
  }
  soundHeaders.placar.sound = love.audio.newSource('assets/sounds/placar.mp3', 'static')
  soundHeaders.sobre:set {
    shape = {
      width = 60,
      height = 60
    }
  }
  soundHeaders.sobre.sound = love.audio.newSource('assets/sounds/sobre.mp3', 'static')
  soundHeaders.sair:set {
    shape = {
      width = 60,
      height = 60
    }
  }
  soundHeaders.sair.sound = love.audio.newSource('assets/sounds/sair.mp3', 'static')

  cursor = Cursor:new {
    botoes = { playBtn, placarBtn, sobreBtn, sairBtn, soundHeaders.play, soundHeaders.placar, soundHeaders.sobre, soundHeaders.sair }
  }

  playImage = Image:new({ name = "play.png", width = 60, height = 60 })
  titleImage = Image:new({ name = "titulo.png", width = 487, height = 225 })

  volumeSlider = newSlider(love.graphics.getWidth() - 50, love.graphics.getHeight() - 100, 300, 1, 0, 1,
    function(v) love.audio.setVolume(1) end,
    { width = 50, orientation = 'vertical', track = 'roundrect', knob = 'circle' })
  --screenshakeSlider = newSlider(400, 310, 300, screenshake, 0.5, 2, function (v) screenshake = v end, {width=20, orientation='horizontal', track='line', knob='rectangle'})

  menu.resize()
end

function menu.update(dt)
  -- Atualizar lógica
  volumeSlider:update()
end

function menu.draw()
  -- Desenhar elementos
  titleImage:draw(playBtn.position.x, 107.5)
  playBtn:draw()
  placarBtn:draw()
  sobreBtn:draw()
  sairBtn:draw()
  soundHeaders.play:draw()
  soundHeaders.play:setBorder()
  soundHeaders.placar:draw()
  soundHeaders.placar:setBorder()
  soundHeaders.sobre:draw()
  soundHeaders.sobre:setBorder()
  soundHeaders.sair:draw()
  soundHeaders.sair:setBorder()
  -- playImage:draw(playBtn.position.x, playBtn.position.y - 25)

  -- local r, g, b, a = love.graphics.getColor()
  -- love.graphics.setColor(love.math.colorFromBytes(36, 87, 197))
  -- volumeSlider:draw()
  -- love.graphics.setColor(r, g, b, a)
end

function menu.keypressed(key)
  -- Lidar com teclas pressionadas
end

function menu.mousepressed(x, y, button, istouch, presses)
  playBtn:onClick(x, y, button, (function()
    Game.animals              = {}
    Game.level1               = {}
    Game.level1.currentRound  = 0
    Game.level1.totalRounds   = 10
    Game.level1.next = function()
      Game.level1.currentRound = Game.level1.currentRound + 1
      Game.level1.animals = utils.array:getRandomDistinctElements(animalsIndex, 4) or
        { "MACACO", "RATO", "RINOCERONTE", "TARTARUGA" }
      Game.animal = Game.level1.animals[1+math.floor(math.random()*#Game.level1.animals)] or "MACACO"
      for _,v1 in ipairs(Game.level1.animals) do
        local tem=false
        for _,v2 in ipairs(Game.animals) do
          if v1==v2 then
            tem=true
            break
          end
        end
        if not tem then
          table.insert(Game.animals, v1)
        end
      end
    end
    Game.level1.next()
    Game.currentLevel = 2
    Game.load()
  end))
  placarBtn:onClick(x, y, button, (function()
    Game.currentLevel = 10
    Game.load()
  end))
  sobreBtn:onClick(x, y, button, (function()
    Game.currentLevel = 8
    Game.load()
  end))
  sairBtn:onClick(x, y, button, (function()
    love.event.quit()
  end))
  soundHeaders.play:onClick(x, y, button, (function()
    soundHeaders.play.sound:play()
  end))
  soundHeaders.placar:onClick(x, y, button, (function()
    soundHeaders.placar.sound:play()
  end))
  soundHeaders.sobre:onClick(x, y, button, (function()
    soundHeaders.sobre.sound:play()
  end))
  soundHeaders.sair:onClick(x, y, button, (function()
    soundHeaders.sair.sound:play()
  end))
  -- sobreBtn:onClick(x, y, button, (function()
  --   Game.currentLevel = 5
  --   Game.load()
  -- end))
end

function menu.mousemoved(x, y, dx, dy, istouch)
  cursor:update(x, y)
end

function menu.resize()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local mBtnH = sairBtn.shape.height

  midW = (windowWidth) / 2 --miniButtonHeigh

  playBtn.position.x = midW
  playBtn.position.y = windowHeight - (4 * mBtnH) - 60

  placarBtn.position.x = midW
  placarBtn.position.y = windowHeight - (3 * mBtnH) - 30

  sobreBtn.position.x = midW
  sobreBtn.position.y = windowHeight - (2 * mBtnH) - 20

  sairBtn.position.x = midW
  sairBtn.position.y = windowHeight - mBtnH - 10

  soundHeaders.play:set {
    position = { playBtn.position.x + (2*soundHeaders.placar.shape.width + playBtn.shape.width)/2, playBtn.position.y }
  }

  soundHeaders.placar:set {
    position = { placarBtn.position.x + (2*soundHeaders.placar.shape.width + placarBtn.shape.width)/2, placarBtn.position.y }
  }

  soundHeaders.sobre:set {
    position = { sobreBtn.position.x + (2*soundHeaders.sobre.shape.width + sobreBtn.shape.width)/2, sobreBtn.position.y }
  }

  soundHeaders.sair:set {
    position = { sairBtn.position.x + (2*soundHeaders.sair.shape.width + sairBtn.shape.width)/2, sairBtn.position.y }
  }

  volumeSlider.x = windowWidth - volumeSlider.width
  volumeSlider.y = windowHeight - volumeSlider.length * 7 / 8
end

return menu
