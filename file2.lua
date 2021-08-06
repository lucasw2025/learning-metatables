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

-------------------------

local metatableDescriptions = { -- description of these OOP objects
	__index = "a table that's entries get applied to the table, if __index is a function, it is called and the item returned is used as the table",
	__newindex = [[this function is called when something happens to the table, like tbl[key] = value, passing on tbl, key, and value to this function
	rawset(tbl,key,value) skips this
	]],
	__call = "when this table is called as if it was a function, the function assigned to __call is executed",
	__metatable = "if getmetatable(tbl) is called, and __metatable exists, it returns __metatable's value instead of the real metatable",
	__tostring = "function called when tostring(metatable) is called and returns what __tostring's function returns",
	__len = "returns what happens when attempting to use call operator ('#') on this metatable",
	
}
