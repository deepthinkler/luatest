luasql = require "luasql.sqlite3"

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

env = assert(luasql.sqlite3())

db =assert(env:connect("test.db"))

 
db:setautocommit(false)

res = db:execute [[CREATE TABLE people(name text, sex text)]]

res = assert(db:execute [[INSERT INTO people VALUES('test','nan')]])
res = assert(db:execute [[INSERT INTO people VALUES('程序猿','男')]])

res = assert(db:execute [[INSERT INTO people VALUES('程序猿老婆', '女')]])

assert(db:commit())

 

res = assert(db:execute [[SELECT * FROM people]])

colnames = res:getcolnames()

coltypes = res:getcoltypes()

enumSimpleTable(colnames)

enumSimpleTable(coltypes)

for r in rows(res) do
    enumSimpleTable(r)
end

res:close()

db:close()

env:close()