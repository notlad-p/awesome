-- NOTE: title case recipe taken from:
-- http://lua-users.org/wiki/StringRecipes
local function title_case(str)
  return str:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)
end

return title_case
