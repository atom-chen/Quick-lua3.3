--
-- Author: wzg
-- Date: 2014-12-21 14:26:20
--

function newLabelAtlas(text, png, width, height, start)
	return cc.LabelAtlas:_create(text, png, width, height, string.byte(start))
end


function progressTo_(time,v)
    local progress = cc.ProgressTo:create(time, v)
    return progress
end

--local text = "哈哈，我关心你，你　\n还说没人关心！真郁闷"   
--local index = string.utf8Index(text)
--dump(index)
--local size = index.size
--for i=1, size do
--    print(tostring(i) .. " => " .. string.sub(text,0,index[i]))
--end
function string.utf8Index(input)
    local len  = string.len(input)
    local left = len
    local cnt  = 1
    local index = {}
    index[cnt] = left
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
        index[cnt] = left
    end
    local size = cnt - 1
    local result = {}
    
    for i=1, cnt-1 do
        result[i] = index[cnt-i]
    end    
    result.size = cnt-1
    
    return result
end

-- start --
    -- local a = 0
    -- local callSize = 5
    -- function cal(dt) 
    --     a = a + 1
    --     log(tostring(a))
    -- end
    -- performWithDelayGlobalWithTimes(cal,1,callSize)
-- end --
-- listener 函数
-- time 间隔多长时间调用一次
-- count 调用 几次关闭
function performWithDelayGlobalWithTimes(listener, time, count)
    local sharedScheduler = cc.Director:getInstance():getScheduler()
    local callCount = 0
    local handle 
    handle = sharedScheduler:scheduleScriptFunc(function()
        print("listener call ")
        listener()
        callCount = callCount + 1
        if callCount >= count then
            print("listener call ")
            sharedScheduler:unscheduleScriptEntry(handle)
        end
    end, time, false)
end


