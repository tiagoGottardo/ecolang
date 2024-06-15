local t = {}

function t.sanitizeMin(val, min)
  if type(min) ~= 'number' or type(val) ~= 'number' then
    return nil
  end

  return math.max(val, min)
end

function t.sanitizeRange(val, min, max)
  if type(val) ~= 'number' or type(min) ~= 'number' or type(max) ~= 'number' then
    return nil
  end

  return math.max(math.min(val, max), min)
end

return t
