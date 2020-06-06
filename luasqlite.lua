sqlite3 = require "luasql.sqlite3"

function enumSimpleTable(t)

         print"-------------------"

         for k,v in pairs(t) do

                   print(k, " = ", v)

         end

         print"-------------------\n"

end

function rows(cur)

         return function(cur)

                   localt = {}

                   if(nil~= cur:fetch(t, 'a')) then return t

                   else return nil end

         end,cur

end

env = assert(sqlite3.sqlite3())

db =assert(env:connect("data/birth.db"))
--db =assert(env:connect("test.db"))

 
-- db:setautocommit(false)

-- res = db:execute [[CREATE TABLE people(name text, sex text)]]

-- res = assert(db:execute [[INSERT INTO people VALUES('程序猿','男')]])

-- res = assert(db:execute [[INSERT INTO people VALUES('程序猿老婆', '女')]])

-- assert(db:commit())

 

res = assert(db:execute [[SELECT * FROM birth_secret]])

colnames = res:getcolnames()

coltypes = res:getcoltypes()

enumSimpleTable(colnames)

enumSimpleTable(coltypes)

for r in rows(res) do
    enumSimpleTable(r)
end

row = res:fetch ({}, "a")
print("输出内容")
while row do
  print(string.format("%s, %s, %s", row.month, row.day, row.content))
  row = res:fetch (row, "a")
end

res:close()

db:close()

env:close()