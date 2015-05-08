cc.utils = require("framework.cc.utils.init")
local ByteArray = cc.utils.ByteArray
local ByteArrayVarint = cc.utils.ByteArrayVarint



MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)


function MainScene:ctor()

    cc.ui.UIPushButton.new()
        :setButtonLabel(cc.ui.UILabel.new({text = "发送一次数据", size = 32}))
        :onButtonClicked(function()
            self:_onTest1()
        end)
        :align(display.CENTER, display.cx, display.top - 32)
        :addTo(self)

    cc.ui.UIPushButton.new()
        :setButtonLabel(cc.ui.UILabel.new({text = "Test length of long", size = 32}))
        :onButtonClicked(function()
            self:_onTest3()
        end)
        :align(display.CENTER, display.cx, display.top - 96)
        :addTo(self)

    -- display.newSprite("bg/bg_1136.png",display.cx,display.cy):addTo(self)

    self.label = cc.ui.UILabel.new({
            font = FONT_NAME,
            UILabelType = 2, text = "Hello, World 1235 您好，世界", size = 24})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)


-- NetCallBack = {}


    -- TypingLabel.new({
    --     text = "黄巾abc贼兵就在215前方，我们快追！！！",
    --     font = FONT_NAME,
    --     size = 34,
    --     color = cc.c3b(255, 255, 255), -- 使用纯红色
    --     align = cc.TEXT_ALIGNMENT_LEFT,
    --     valign = cc.VERTICAL_TEXT_ALIGNMENT_TOP,
    --     dimensions = cc.size(700, 300),
    --     finishCall = function() 
    --         -- printf("打印结束 ")
    --         -- display.replaceScene(FightScene.new())
    --     end
    -- }):align(display.CENTER, display.cx, display.cy-100)
    --     :addTo(self)

    -- local timerLabel = TimerLabel.new({
    --     time = 6000,
    --     format = "@M:@S",
    --     finish = function()
    --         -- printf("倒计时结束 ")
    --     end
    -- })
    -- timerLabel:align(display.LEFT_TOP,50,display.height - 50):addTo(self)

    -- local function dataLoaded(percent)
    --     -- print("加载回调函数" .. tostring(percent))
    --     if percent >= 1 then
    --         -- printf("哈哈  哈哈  哈哈")
    --         -- display.replaceScene(FightScene.new())
    --     end
    -- end

    -- local manager = ccs.ArmatureDataManager:getInstance()
    -- print("战斗加载骨胳  开始")
    -- manager:addArmatureFileInfoAsync("armature/act1.ExportJson", dataLoaded)
    -- manager:addArmatureFileInfoAsync("armature/tauren.ExportJson", dataLoaded)
    -- manager:addArmatureFileInfoAsync("armature/fengjingling.ExportJson", dataLoaded)

    
    -- print("战斗加载骨胳  完成")

           


    -- for i=1,3 do
    --     local fight = testFightCmds['f'..tostring(i)]
    --     -- local idx = 1
    --     for j=1,20 do
    --         local cmd = fight['c'..tostring(j)]
    --         if cmd == nil then
    --             break
    --         end
    --         local t = {}
    --         local size = cmd.size
    --         logf("size => %d " , size)
    --         for k=1,size do
    --             local action = cmd[tostring(k)]

    --             local hurtSize = action.behurtInfos.hurtSize

    --             if hurtSize == nil then hurtSize = 1 end
    --             local hs = {}
    --             for h=1,hurtSize do
    --                 local hurtInfo = action.behurtInfos[tostring(h)]
    --                 hs[h] = FightAction.buildHurtInfoWidthObj(hurtInfo)
    --             end
    --             local hurtInfos = FightAction.buildBeHurtInfosWidthArray(hs)
    --             local actionStr = FightAction.buildAction(action.runnerID, action.attType, hurtInfos)
    --             t[k] = actionStr
    --         end
    --         local cmdActions = Cmd.buildActionsWidthArray(t)
    --         local cmdStr = Cmd.buildCmd(cmd.isNpc, cmd.size, cmdActions)
    --         logf("f%d , c%d => %s" , i , j , cmdStr)
    --     end
    --     logf("")
    -- end

end

function MainScene:_getDataByLpack()
    local __pack = string.pack("<bihP2", 0x59, 11, 1101, "", "中文")
    return __pack
end

function MainScene:_getByteArray()
    return ByteArray.new()
        :writeByte(0x59)
        :writeInt(11)
        :writeShort(12422)
        :writeStringUShort("")
        :writeStringUShort("中文")
end

function MainScene:_onTest1()
    -- printf("mainScene -> %s" , tostring(self))
    net:SendData()
    -- display.replaceScene(  LoginScene.new() )
    -- local __pack = self:_getDataByLpack()
    -- local __ba1 = ByteArray.new()
    -- :writeBuf(__pack)
    -- :setPos(1)
    -- print("ba1.len:", __ba1:getLen())
    --     -- print("ba1.available:", __ba1:getAvailable())
    -- print("ba1.readByte:", __ba1:readByte())
    --     -- print("ba1.available:", __ba1:getAvailable())
    -- print("ba1.readInt:", __ba1:readInt())
    --     -- print("ba1.available:", __ba1:getAvailable())
    -- print("ba1.readShort:", __ba1:readShort())
    --     -- print("ba1.available:", __ba1:getAvailable())
    -- print("ba1.readString:", __ba1:readStringUShort())

    -- print("ba1.readString:", __ba1:readStringUShort())
    -- print("ba1.available:", __ba1:getAvailable())
    -- print("ba1.len:", __ba1:getLen())
    -- print("ba1.toString(16):", __ba1:toString(16))
    -- print("ba1.toString(10):", __ba1:toString(10))

    -- __ba1:setPos(1)
    -- print("ba1.available:", __ba1:getAvailable())

    -- local __ba2 = self:_getByteArray()
    -- print("ba2.toString(10):", __ba2:toString(10))


    

    -- local __ba3 = ByteArray.new()
    -- local __str = ""
    -- for i=1,20 do
    -- __str = __str.."ABCDEFGHIJ"
    -- end
    -- __ba3:writeStringSizeT(__str)
    -- __ba3:setPos(1)
    -- print("__ba3:readUInt:", __ba3:readUInt())

end

function MainScene:_onTest2()
    print("test2")
    local ba = ByteArrayVarint.new(ByteArrayVarint.ENDIAN_BIG)
        :writeInt(34)
    print(ba:toString(), ba:getLen())
    print(string.format("buf all bytes:%s, %d", 
        ByteArray.toString(ba:getBytes(), 16), 
        ba:getLen()))
end

function MainScene:_onTest3()
    print("test3")
    local l = string.pack("l", 32333)
    print(#l)
    local L = string.pack("L", 33333)
    print(#L)
    local i = string.pack("i", 32333)
    print(#i)
    local I = string.pack("I", 33333)
    print(#I)
end


function MainScene:netCallBack4(data)
    printf("mainScene -> %s" , tostring(self))
    self.label:setString(data)
end


function MainScene:onEnter()
	print(" MainScene onEnter ")

    net = MyNet.new()
    net:Connect()

    NetCallBack[1]("aaa")
    NetCallBack[2]("bbb")
    NetCallBack[3]("cccc")


    NetCallBack[8] = handler(self, self.netCallBack4)

    -- NetCallBack[3]("ccc")

-- local layer = display.newLayer()
-- self:addChild(layer)
-- layer:setTouchEnabled(true)

-- layer:setTouchSwallowEnabled(false)
-- layer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
-- layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
-- local x, y, prevX, prevY = event.x, event.y, event.prevX, event.prevY
 
--     if event.name == "began" then

--         self.pause = self.pause or 0
--         if self.pause == 0 then
--             self.pause = 1
--         else 
--             self.pause = 0
--             -- self.hero:zorder(5)
--         end
--         --setSpeedScale(self.pause)
--         print("layer began x=>"..tostring(x) .. " , y=>"..tostring(y) .. " , prevX=>"..tostring(prevX) .. " , prevY=>" .. tostring(prevY))
--     elseif event.name == "moved" then
--         print("layer moved x=>"..tostring(x) .. " , y=>"..tostring(y) .. " , prevX=>"..tostring(prevX) .. " , prevY=>" .. tostring(prevY))
--     elseif event.name == "ended" then
--         print("layer ended x=>"..tostring(x) .. " , y=>"..tostring(y) .. " , prevX=>"..tostring(prevX) .. " , prevY=>" .. tostring(prevY))
--     end
--         return true
--     end)

--     layer:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function (event)
--         if event.name == "began" then
--             print("layer capture began")
--         elseif event.name == "moved" then
--             print("layer capture moved")
--         elseif event.name == "ended" then
--             print("layer capture ended")
--         end
 
--         return true
--     end)
	
end

function MainScene:onExit()
	print(" MainScene onExit ")

    -- net:onExit()

end

-- return MainScene

    -- local a = {}
    -- for i=1,10 do
    --     a[tostring(i)] = false
    --     logf("%d => %s",i,tostring(a[tostring(i)]))
    -- end
    -- a['3'] = true
    -- a['6'] = true
    -- a['9'] = true

    -- for i=1,10 do
    --     local k = a[tostring(i)]
    --     if k == true then
    --         continue
    --     end
    --     logf("%d => %s",i,tostring(k))
    -- end

