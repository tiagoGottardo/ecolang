local utils = {}

function utils:getRandomDistinctElements(array, n)
  math.randomseed(os.time())

  local function shuffle(tbl)
    local len = #tbl
    for i = len, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
  end

  local shuffledArray = shuffle(array)

  local distinctElements = {}

  local count = 0
  for _, element in ipairs(shuffledArray) do
    if not distinctElements[element] then
      distinctElements[element] = true
      count = count + 1
      if count == n then
        break
      end
    end
  end

  local result = {}
  for key, _ in pairs(distinctElements) do
    table.insert(result, key)
  end

  return result
end

return utils
