local t = {}

function t:deepCopy(tab)
  if type(tab) ~= 'table' then
    return nil
  end

  local a = {}
  for key, val in pairs(tab) do
    a[key] = self:deepCopy(val) or val
  end

  return a
end

function t:shallowCopy(tab)
  if type(tab) ~= 'table' then
    return nil
  end

  local a = {}
  for key, val in pairs(tab) do
    a[key] = val
  end

  return a
end

return t
