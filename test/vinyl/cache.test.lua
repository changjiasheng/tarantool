#!/usr/bin/env tarantool

test_run = require('test_run').new()

s = box.schema.space.create('test', {engine = 'vinyl'})
i = s:create_index('test')

str = string.rep('!', 100)

for i = 1,1000 do s:insert{i, str} end

t = s:select{}

#t

t = s:replace{100, str}

for i = 1,10 do t = s:select{} end

t = s:replace{200, str}

s:drop()

test_run:cmd("setopt delimiter ';'")
stat = {
    run_step_count = 0,
    run_lookup_count = 0,
    mem_step_count = 0,
    mem_lookup_count = 0,
}
function stat_changed() 
    local old_stat = stat
    local new_stat = box.info.vinyl().performance["iterator stat"]
    stat = {
        run_step_count=new_stat.run.step_count, 
        run_lookup_count=new_stat.run.lookup_count, 
        mem_step_count=new_stat.mem.step_count, 
        mem_lookup_count=new_stat.mem.lookup_count, 
    }
    for k,v in pairs(stat) do
        if old_stat[k] ~= v then
            return true
        end
    end
    return false
end;
test_run:cmd("setopt delimiter ''");

s = box.schema.space.create('test', {engine = 'vinyl'})
i1 = s:create_index('test1', {parts = {1, 'uint', 2, 'uint'}})

str = ''

s:replace{0, 0, 0}
s:replace{1, 1, 1, str}
s:replace{1, 2, 1, str}
s:replace{1, 3, 1, str}
s:replace{1, 4, 1, str}
s:replace{2, 1, 2, str}
s:replace{2, 2, 2, str}
s:replace{2, 3, 2, str}
s:replace{2, 4, 2, str}
s:replace{3, 3, 4}

box.snapshot()
a = stat_changed() -- init

box.begin()
s:get{1, 2}
box.commit()
stat_changed()  -- cache miss, true

s:get{1, 2}
stat_changed() -- cache hit, false

box.begin()
s:select{1}
box.commit()
stat_changed()  -- cache miss, true

s:select{1}
stat_changed() -- cache hit, false

box.begin()
s:select{}
box.commit()
stat_changed()  -- cache miss, true

s:select{}
stat_changed() -- cache hit, false

s:drop()

s = box.schema.space.create('test', {engine = 'vinyl'})
i1 = s:create_index('test1', {parts = {1, 'uint', 2, 'uint'}})

str = ''

s:replace{0, 0, 0}
s:replace{1, 1, 1, str}
s:replace{1, 2, 1, str}
s:replace{1, 3, 1, str}
s:replace{1, 4, 1, str}
s:replace{2, 1, 2, str}
s:replace{2, 2, 2, str}
s:replace{2, 3, 2, str}
s:replace{2, 4, 2, str}
s:replace{3, 3, 4}

box.snapshot()
a = stat_changed() -- init

box.begin()
s:select{}
box.commit()
stat_changed()  -- cache miss, true

s:get{1, 2}
stat_changed() -- cache hit, false

s:select{1}
stat_changed() -- cache hit, false

s:select{}
stat_changed() -- cache hit, false

s:drop()

