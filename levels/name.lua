local Name = {}
local userInput = ""

function Name.load()
  Name.keyboard.setKeyRepeat(true) -- Permite repetição de tecla
end

function Name.update(dt)
  -- Se necessário, lógica de atualização pode ser colocada aqui
end

function Name.draw()
  -- Desenha o conteúdo da janela
  love.graphics.printf("Digite algo e pressione Enter:", 0, 200, love.graphics.getWidth(), "center")
  love.graphics.printf(userInput, 0, 240, love.graphics.getWidth(), "center")
end

function Name.keypressed(key)
  if key == "backspace" then
    -- Remove o último caractere do texto
    userInput = userInput:sub(1, -2)
  elseif key == "return" then
    -- Aqui você pode usar o userInput conforme necessário
    print("Texto digitado:", userInput)
    -- Limpa o input após pressionar Enter
    userInput = ""
  else
    -- Adiciona caracteres ao texto
    userInput = userInput .. key
  end
end
