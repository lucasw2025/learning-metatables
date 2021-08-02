-- https://www.youtube.com/watch?v=CYxMfVy5W00
-- video made August 18, 2011

local john = {}
print(john.money) --> nil, nonexistent

local bill = {money = 999}
print(bill.money) --> 999, bill's money value

local metatable = {__index = bill}
setmetatable(john, metatable)

print(john.money) --> 999, set

--[[ // full output
nil
999
999
--]]

-------------------------

John = {}
John.prototype = {
	speed = 5, -- speed is 5
	strength = 100
}
John.metatable = {__index = John.prototype}

function John:new()
	local o = {}
	setmetatable(o, John.metatable)
	return o
end

local JohnClone = John:new()
print(JohnClone.speed) --> 5, since it used John's speed

--[[
JohnClone is "o" from John:new(), and that "o" was set John.metatable,
and John.metatable.__index was John.prototype,
and John.prototype.speed was 5
so JohnClone's speed should be 5, too
--]]

--[[ // full output
5
--]]

-------------------------

John = {}
John.prototype = {
	speed = 5,
	strength = 100
}
John.metatable = {__index = John.prototype}

function John:new(o) -- takes a table o
	setmetatable(o, John.metatable)
	return o
end

local JohnClone = John:new({speed = 4})
print(JohnClone.speed) --> 4, because we have passed in a table already and it gets set to the metatable which is pointing to the prototype.
print(JohnClone.strength) --> 100, since we didn't define strength in the table you passed in, it's still the default value

--[[
i'm new to this, but i'm guessing already set properties of tables don't get set with setmetatable
the speed is 4 overrides anything John:new() sets with setmetatable
--]]

--[[ // full output
4
100
--]]

--[[ // conclusion
setting a metatable sets all of the second argument table's entries to the first argument table, ignoring already set entries in the first argument table
--]]

-----------------------------------------------------------------------------------------------------------------------------

-- https://www.youtube.com/watch?v=Uz3B1rFZ4oM
-- video made August 19, 2011

local dog = {}

dog() --X attempt to call 'dog' (a table value)

--[[ // full output
X attempt to call 'dog' (a table value)
--]]

-------------------------

local dog = {}

local metatable = {__call = function(table)
	print("I am now a functable!")
end}

setmetatable(dog, metatable)
dog() --> I am now a functable!

--[[ // full output
I am now a functable!
--]]

-------------------------

--[[
functables as writing a function that can have tables that assigned to it, so like functions wiht properties or values
--]]

local getPerson = {}

local metatable = {__call = function(table, key)
	local person = {name = key}
	return person
end}

setmetatable(getPerson, metatable)

local john = getPerson("John")
print(john,john.name) --> table: 0021C670 | John

--[[ // full output
table: 0021C670 | John
--]]

-------------------------

-- now attempting to only have one of each person

local getPerson = {}
getPerson.cache = {}

local metatable = {__call = function(table, key) -- the table (aka ({...})[1])) item is getPerson when we called setmetatable(getPerson, metatable) after this function
	if table.cache[key] then return table.cache[key] end -- return the already existing table
	
	local person = {name = key}
	table.cache[key] = person
	return person
end}

setmetatable(getPerson, metatable)

local john = getPerson("John")
print(john,john.name) --> table: 0088C698 | John

local anotherDude = getPerson("John")
print(anotherDude, anotherDude.name) --> table: 0088C698 | John

local bill = getPerson("Bill")
print(bill, bill.name) --> table: 0029C760 | Bill

--[[ // full output
table: 0088C698 | John
table: 0088C698 | John
table: 0029C760 | Bill
--]]

--[[ // conclusion
because the table __call was set to getPerson through setmetatable, making it use the function assigned to __call when getPerson is called
--]]
