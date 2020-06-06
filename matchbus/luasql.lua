sqlite3 = require "luasql.sqlite3"
function testsql()
local env  = sqlite3.sqlite3()
local conn = env:connect('data/birth.db')
print(env,conn)

-- status,errorString = conn:execute([[CREATE TABLE sample ('id' INTEGER, 'name' TEXT)]])
-- print(status,errorString )

-- status,errorString = conn:execute([[INSERT INTO sample values('1','Raj')]])
-- print(status,errorString )

cursor,errorString = conn:execute([[select * from birth_secret]])
print(cursor,errorString)

row = cursor:fetch ({}, "a")
while row do
  print(string.format("%s, %s, %s", row.month, row.day, row.content))
  row = cursor:fetch (row, "a")
end
-- close everything
cursor:close()
conn:close()
env:close()
end