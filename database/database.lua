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
    if left[1].score >= right[1].score then
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

local database = {
  data = { plays = {} }
}

function database:createPlay(play)
  self.data = self.data or {}
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

function database:getReport(i)
  if i == 0 then
    return
  end

  return self.data.plays[i]
end

function database:getReports()
  local reports = {}

  for i = 1, #self.data.plays do
    reports[i] = { name = self.data.plays[i].name, score = self.data.plays[i].playedAt.date or "--/--/----" }
  end

  return reports
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

local function removeFirstNElements(t, N)
  for _ = 1, N do
    table.remove(t, 1)
  end
end

function database:saveData()
  local file = io.open("database/db.json", "w+")
  if not file then
    return print "Some problem happened in get file content."
  end
  if #self.data.plays > 14 then
    removeFirstNElements(self.data.plays, #self.data.plays - 14)
  end
  local data = json.encode(self.data)
  if type(data) == 'string' then
    file:write(data)
    file:close()
    return
  end
  print "Data is not a valid json."
end

function database:loadData()
  local file = io.open("database/db.json", "r")
  if not file then
    print "No data file found!"
    return
  end
  local data = file:read("*a")
  self.data = json.decode(data) or { plays = {} }
  file:close()
end

database:loadData()

return database
