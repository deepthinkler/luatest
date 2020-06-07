
local env = require "lsqlite3"
local conn = env.open('data/birth.db')

local function do_query(sql)
    local r
    local vm = conn:prepare(sql)
    assert(vm, conn:errmsg())
    print('====================================')
    print(vm:get_unames())
    print('------------------------------------')
    r = vm:step()
    while (r == env.ROW) do
        print(vm:get_uvalues())
        r = vm:step()
    end
    assert(r == env.DONE)
    assert(vm:finalize() == env.OK)
    print('====================================')
end


print(env,conn)

-- status,errorString = conn:execute([[CREATE TABLE sample ('id' INTEGER, 'name' TEXT)]])
-- print(status,errorString )

-- status,errorString = conn:execute([[INSERT INTO sample values('1','Raj')]])
-- print(status,errorString )

do_query("select * from birth_secret")
