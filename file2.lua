local baseTbl = {}
local metatable = {__index = function (t, k)  -- {} an empty table, and after the comma, a custom function failsafe
  return "key doesn't exist"
end}

local func_example = setmetatable(baseTbl, metatable)

print(baseTbl,metatable,func_example) -- testing what setmetatable returns
-- ^ this prints same as baseTbl; guess we don't need to make a variable for baseTable, just func_example and directly inserting a table to setmetatable

-- table: 0x5654b488a810	table: 0x5654b488a850	table: 0x5654b488a810

-- concluded that metatable returns the table that it was set to

-------------------------

-- guessing for luau, most globals like CFrame and UDim2 are just metatables, as they have the __add to add, __mul for multiplying cframes, etc.
