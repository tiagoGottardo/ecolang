local Level2 = {}

local titulo = nil

function Level2.load()
    titulo = love.graphics.newImage("titulo.png")

    -- Carregar recursos específicos
end

function Level2.update(dt)
    -- Atualizar lógica
end

function Level2.draw()

    love.graphics.draw(titulo,-25,-15,0,0.1,0.1)

    love.graphics.print("Fase2", 400, 300)
    -- Desenhar elementos
end

function Level2.keypressed(key)
    -- Lidar com teclas pressionadas
end

return Level2