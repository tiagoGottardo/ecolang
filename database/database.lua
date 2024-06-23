local json = require("dkjson")

local function splitArray(arr)
  local mid = math.floor(#arr / 2)
  local left = {}
  local right = {}

  for i = 1, mid do
    table.insert(left, arr[i])
  end

  for i = mid + 1, #arr do
    table.insert(right, arr[i])
  end

  return left, right
end
local function merge(left, right)
  local merged = {}

  while #left > 0 and #right > 0 do
    if left[1].score <= right[1].score then
      table.insert(merged, table.remove(left, 1))
    else
      table.insert(merged, table.remove(right, 1))
    end
  end

  while #left > 0 do
    table.insert(merged, table.remove(left, 1))
  end

  while #right > 0 do
    table.insert(merged, table.remove(right, 1))
  end

  return merged
end

local function mergeSort(arr)
  if #arr <= 1 then
    return arr
  end

  local left, right = splitArray(arr)

  left = mergeSort(left)
  right = mergeSort(right)
  return merge(left, right)
end

-- plays = {
--  name = "",
--  score = 320
--  errors = {
--    level1 = {
--      Tentativa = "",
--      Resposta Correta = "" }, level2 = {
--      Tentativa = "",
--      Resposta Correta = ""
--    },
--    level3 = {
--      Tentativa = "",
--      Resposta Correta = ""
--    },
--  },
--  times = {
--    level1 = 200, level2 = 20, level3 = 70, total = 290
--  },
--  playedAt = {
--    time = 17:15,
--    date = 10/11/1989
--  } }
--

local database = {
  data = { plays = {} }
}

function database:createPlay(play)
  table.insert(self.data.plays, play)
  print "Play added successfully!"
end

function database:getPlay(playId)
  local play = self.data.plays[playId]
  if not play then
    print "That play does not exist!"
  end

  return play
end

function database:getRanking()
  local ranking = {}
  for key, val in pairs(self.data.plays) do
    ranking[key] = { name = val.name, score = val.score }
  end
  ranking = mergeSort(ranking)

  return ranking
end

function database:getPlays()
  return self.data.plays
end

function database:saveData()
  local file = io.open("database/db.json", "w+")
  if not file then
    return print "Some shit happen!"
  end
  local data = json.encode(self.data)
  file:write(data)
  file:close()
  print "Data saved successfully!"
end

function database:loadData()
  local file = io.open("db.json", "r")
  if not file then
    print "No data file found!"
    return
  end
  local data = file:read("*a")
  self.data = json.decode(data)
  file:close()
  print "Data loaded successfully!"
end

database:loadData()

return database
