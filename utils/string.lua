local utils = {}
local utf8  = require 'utf8'

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

function utils:utf8ToTable(str)
  local tab={}
  if type(str)=='string' then
    for _, c in utf8.codes(str) do
      table.insert(tab, utf8.char(c))
    end
  end
  return tab
end

function utils:upperUtf8(str)
  if type(str)~='string' then
    return ''
  end
  local str1=''
  local accents = {
    ['á'] = 'Á',
    ['â'] = 'Â',
    ['à'] = 'À',
    ['ã'] = 'Ã',
    ['ä'] = 'Ä',
    ['é'] = 'É',
    ['ê'] = 'Ê',
    ['è'] = 'È',
    ['ë'] = 'Ë',
    ['í'] = 'Í',
    ['î'] = 'Î',
    ['ì'] = 'Ì',
    ['ï'] = 'Ï',
    ['ó'] = 'Ó',
    ['ô'] = 'Ô',
    ['ò'] = 'Ò',
    ['õ'] = 'Õ',
    ['ö'] = 'Ö',
    ['ú'] = 'Ú',
    ['û'] = 'Û',
    ['ù'] = 'Ù',
    ['ü'] = 'Ü',
    ['ç'] = 'Ç',
    ['ñ'] = 'Ñ'
  }
  for _, v in utf8.codes(str) do
    local char=utf8.char(v)
    str1 = str1 .. (accents[char] or char:upper())
  end
  return str1
end

function utils:firstUtf8Char(str)
  if type(str) ~= 'string' then
    return ''
  end
  for _, c in utf8.codes(str) do
    return utf8.char(c)
  end
  return ''
end

return utils
