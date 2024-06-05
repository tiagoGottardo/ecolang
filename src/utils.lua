local utils={}

function utils:tostring(val)
  local str=tostring(val)
  if type(val)=='string' then
    str=('%q'):format(val)
  elseif type(val)=='table' then
    str='{'
    local ehPrimeiro=true
    for k,v in pairs(val) do
      if not ehPrimeiro then
        str=str..', '
      end
      ehPrimeiro=false

      str=str..('%s=%s'):format(self:tostring(k), self:tostring(v))
    end
    str=str..'}'
  end
  return str
end

return utils
