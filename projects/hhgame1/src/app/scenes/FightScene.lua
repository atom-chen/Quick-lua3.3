
-- Author: wzg
-- Date: 2014-12-19 22:13:19
-- collectgarbage("count")  
-- collectgarbage("collect")
FightScene = class("FightScene", function()
    return display.newScene("FightScene")
end)


function FightScene:ctor()
 print("FightScene ctor()")
    -- math.newrandomseed()
    self.bg = display.newSprite("bg/bg7.png",display.cx,display.cy)
        :align(display.CENTER_LEFT, 0, display.cy)
        :addTo(self,0,0)
    self.initHerosData = testInitHerosData
    -- init 
    self:initHeros()
    self:initUI()
    self.fightFinish = true

    self.isRunnerFinish = {}
    self.curCmd = Cmd.new("1,1CMD1,1HS2_0_50_0")
end


function FightScene:initHeros()
    log("init initHeros")
    -- fight layer
    self.fightLayer = display.newLayer()
    self.fightLayer:addTo(self,3,3)

    -- color effect layer
    self.colorEffectLayer = display.newLayer()
    self.colorEffectLayer:addTo(self,7,7)
    self.redLayer = display.newColorLayer(cc.c4b(255, 0, 0, 200))
    self.redLayer:addTo(self.colorEffectLayer , 1 , 1)
    self.redLayer:setVisible(false)
    self.whiteLayer = display.newColorLayer(cc.c4b(255, 255, 255, 0))
    self.whiteLayer:addTo(self.colorEffectLayer , 3 , 3)
    self.blackLayer = display.newColorLayer(cc.c4b(0, 0, 0, 0))
    self.blackLayer:addTo(self.colorEffectLayer , 5 , 5)

    -- hero icon click event function
    local iconClick = function(event)
        local x, y = event.x, event.y
        local playerSize = self.initHerosData.player.size
        for i=1, playerSize do
            local hero = self.playerHeros[tostring(i)]
            local result = cc.rectContainsPoint(hero.icon:getBoundingBox(), cc.p(x,y))
            if result == true or result == "true" then
                print(" hero icon is clicked, id => %d" , hero.id)
            end    
        end
        return true
    end

    -- menu layer
    self.menuLayer = display.newLayer()
    self.menuLayer:addTo(self, 10, 10)
    self.menuLayer:setTouchEnabled(true)
    self.menuLayer:setTouchSwallowEnabled(false)
    self.menuLayer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
    self.menuLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, iconClick)

    -- fight index label init for not nil
    self.fightLabel = cc.ui.UILabel.new({
            UILabelType = 2, font = FONT_NAME, text = "第 0 场", size = 20})
        :align(display.CENTER_TOP, display.cx, display.height - 25)
        :addTo(self.menuLayer)

    -- 设置 两个 变量 存 战斗双方数值
    -- self.playerData = {}
    -- self.npcData = {}

    self.playerHeros = {}
    self.npcHeros = {}

    self.fightIdx = 1

    self:initPlayerHero(self.initHerosData)
    self:initNPCHero(self.initHerosData, self.fightIdx)
end

function FightScene:effect(effectType)
    if effectType == 1 then
        local sequence = transition.sequence({
                cc.MoveBy:create(0.06,cc.p(0,15)),
                cc.MoveBy:create(0.06,cc.p(0,-15)),
                cc.MoveBy:create(0.06,cc.p(0,7)),
                cc.MoveBy:create(0.06,cc.p(0,-7)),
            })

        self.bg:runAction(sequence)
    elseif effectType == 2 then
        -- self.redLayer:setVisible(true)
    elseif effectType == 3 then

    end
end

function FightScene:removeNpcForNextFight()
    for i=1,2 do
        print()
    end

    for i=1, self.npcSize do
        -- logf( "playerLife %d => %d " , i ,self.playerHeros[tostring(i)].curLife)
        self.npcHeros[tostring(i)]:removeFromParent(true)
    end
end

function FightScene:nextFight()
    -- body
    local bgW = self.bg:getContentSize().width

    local sequence = transition.sequence({
        cc.MoveBy:create(2,cc.p( -( (bgW-display.right) / 2),0)),
        cc.CallFunc:create(function()
                self:initNPCHero(self.initHerosData, self.fightIdx)
                self:fightOne()
            end)
    })
    self.bg:runAction(sequence)

    local playerSize = self.initHerosData.player.size
    for i=1,playerSize do
        local hero = self.playerHeros[tostring(i)]
        hero:moveAction()
    end
end

function FightScene:initUI()
    ------- 自动战斗
    self.auto = ScaleButton.new({
            image = "fight/auto.png",
            listener = function(event)
                -- todo
                log("auto Button Clicked")
            end,
        })
        :align(display.CENTER, display.width - 50, 50)
        :addTo(self.menuLayer)

    ------- 暂停退出
    self.pause = ScaleButton.new({
            image = "fight/pause.png",
            listener = function(event)
                -- todo
                log("pause Button Clicked")
            end,
        })
        :align(display.CENTER, 40, display.height - 40)
        :addTo(self.menuLayer)

    ------- 人物Icon头像
    display.newSprite("fight/UIFrame1.png")
        :align(display.BOTTOM_LEFT, 5,  5)
        :addTo(self.menuLayer,1)

    for i = 1 , 5 do
        display.newSprite("fight/UIFrame2.png")
            :align(display.BOTTOM_LEFT, 50 + i * 64,  5)
            :addTo(self.menuLayer,1)
    end

    display.newSprite("fight/UIFrame3.png")
        :align(display.BOTTOM_LEFT, 50 + 6 * 64,  5)
        :addTo(self.menuLayer,1)

    local PROGRESS_LEFT_TO_RIGHT = 0
    local PROGRESS_RIGHT_TO_LEFT = 1

    -- 创建一个从左到右的进度条
    local function newProgressBar(image, progresssType)
        local progress = display.newProgressTimer(image,display.PROGRESS_TIMER_BAR)
        progress:setMidpoint(cc.p(progresssType, 0))
        progress:setBarChangeRate(cc.p(1, 0))
        return progress
    end

    -- 创建玩家icon、血条、行动条，等
    local playerSize = self.initHerosData.player.size
    for i=1,playerSize do
        local heroData = self.initHerosData.player[tostring(i)]
        local hero = self.playerHeros[tostring(i)]
        if heroData.type == "animal" then

            hero.grayIcon = display.newGraySprite(heroData.icon)
            hero.grayIcon:align(display.BOTTOM_LEFT, 53 + heroData.pos * 64, 41)
            hero.grayIcon:addTo(self.menuLayer, 1)

            hero.icon = display.newSprite(heroData.icon)
            hero.icon:align(display.BOTTOM_LEFT, 53 + heroData.pos * 64, 41)
            hero.icon:addTo(self.menuLayer, 2)

            hero.hp = newProgressBar("fight/HP.png",PROGRESS_LEFT_TO_RIGHT)
            hero.hp:align(display.BOTTOM_LEFT, 53 + heroData.pos * 64, 93)
                :addTo(self.menuLayer, 2)
            hero.hp:runAction(progressTo_(0,100))

            hero.sp = newProgressBar("fight/SP.png",PROGRESS_LEFT_TO_RIGHT)
            hero.sp:align(display.BOTTOM_LEFT, 53 + heroData.pos * 64, 31)
                :addTo(self.menuLayer, 2)
            hero.sp:runAction(progressTo_(0,100))

            hero.sp:setColor(cc.c3b(0, 255, 0))

        else

            hero.icon = display.newSprite(heroData.icon)
                :align(display.BOTTOM_LEFT, 20,  20)
                :addTo(self.menuLayer,0)

        end
    end
    ------- 时间条 ----------
    display.newScale9Sprite("fight/border.png",0,0,cc.size(130, 30))
        :align(display.BOTTOM_LEFT, 140, display.height - 50)
        :addTo(self.menuLayer,0)
    display.newSprite("fight/TimeIcon.png")
        :align(display.BOTTOM_LEFT, 125, display.height - 60)
        :addTo(self.menuLayer,0)

    self.time = newLabelAtlas("068/579", "ui/num_white.png", 24, 34, ".")
    self.time:addTo(self.menuLayer, 1):align(display.BOTTOM_LEFT, 170, display.height - 45)
    self.time:setScale(0.6)
    ------- 宝箱------------
    display.newScale9Sprite("fight/border.png",0,0,cc.size(120, 30))
        :align(display.BOTTOM_LEFT, display.right - 170, display.height - 50)
        :addTo(self.menuLayer,0)
    display.newSprite("fight/ItemIcon.png")
        :align(display.BOTTOM_LEFT, display.right - 100, display.height - 60)
        :addTo(self.menuLayer,0)
    local m1 = newLabelAtlas("6579", "ui/num_white.png", 24, 34, ".")
    m1:addTo(self.menuLayer, 1):align(display.BOTTOM_LEFT, display.right - 165, display.height - 45)
    m1:setScale(0.6)

    ------- 财富-------------
    display.newScale9Sprite("fight/border.png",0,0,cc.size(120, 30))
        :align(display.BOTTOM_LEFT, display.right - 340, display.height - 50)
        :addTo(self.menuLayer,0)
    display.newSprite("fight/CoinIcon.png")
        :align(display.BOTTOM_LEFT, display.right - 270, display.height - 60)
        :addTo(self.menuLayer,0)
    local m2 = newLabelAtlas("679", "ui/num_white.png", 24, 34, ".")
    m2:addTo(self.menuLayer, 1):align(display.BOTTOM_LEFT, display.right - 335, display.height - 45)
    m2:setScale(0.6)
    --------------------------------------------

    ------- 第几场战 -------------

    ------- 第几场战 -------------

end

function FightScene:initPlayerHero( initHerosData )    
    local playerSize = initHerosData.player.size
    for i=1, playerSize do
        print( "Hero => " .. tostring(i) )
        local heroInitData = initHerosData.player[tostring(i)]
        -- self.playerData[tostring(i)] = heroInitData

        local p = playerPosition["p".. tostring(heroInitData.pos)]
        local y = display.cy + p.y
        local z = display.height - y

        local hero = Hero.new(heroInitData)
            :align(display.CENTER, display.left + p.x, y)
            :addTo(self.fightLayer, z)
        self.playerHeros[tostring(i)] = hero
        hero.fightScene = self
    end
end

function FightScene:initNPCHero( initHerosData , idx)    
    self.fightLabel:setString(string.format("第 %d 场", idx))

    local npc = initHerosData.npc["npc"..tostring(idx)]
    self.npcSize = npc.size

    for i=1, self.npcSize do

        local heroInitData = npc[tostring(i)]
        -- self.npcData[tostring(heroInitData.pos)] = heroInitData

        local p = npcPosition["p" .. tostring(heroInitData.pos)]
        local y = display.cy + p.y
        local z = display.height - y

        local npc = Hero.new(heroInitData)
            :align(display.CENTER, display.right - p.x, y)
            :addTo(self.fightLayer, z)

        self.npcHeros[tostring(i)] = npc
        npc.fightScene = self

    end
end

function FightScene:fight( dt )

    self:removeAllNodeEventListeners()
    self:unscheduleUpdate()

    self:rePlay()

end

function FightScene:showFightHurt(params)
    local t1 = 3;
    local t2 = 1;
    params.y = params.y + 90;
    local hurt = Hurt.new(
        {status=params.status,hurtNum=params.hurt})
        :align(display.CENTER, params.x, params.y)
        :addTo(self.fightLayer, 2000, 2000)   

    hurt:setScale(0.1);

    if params.status == 1 then 
        self:effect(1)
    end

    local sequence = transition.sequence({
        cc.ScaleTo:create(0.05, t1),
        cc.ScaleTo:create(0.1, t2),
        cc.DelayTime:create(0.75),
        cc.MoveBy:create(0.15,cc.p(0,30)),
        cc.Hide:create()
    })
    hurt:runAction(sequence)
end

function FightScene:rePlay()
    -- 重播的战斗 数据
    self.cmds = testFightCmds

    -- self.curFight = self.cmds['f' .. tostring(self.fightIdx)]
    -- dump(self.curFight)
    self:fightOne()
-- indHurtHero(runnerID , isNpc , pos , attType , howmany)
    -- self:findHurtHero(1,0,1,1)
end
-- 重播使用
function FightScene:fightOne()
    local playerSize = self.initHerosData.player.size
    for i=1,playerSize do
        local hero = self.playerHeros[tostring(i)]
        hero:waitAction()
    end

    self.curFight = self.cmds['f' .. tostring(self.fightIdx)]
    log("FightScene:fightOne()")

    if self.curFight ~= nil then
        self.curCmdIndex = 1
        self:scheduleUpdate()
        self.frameCount = 1

        local frameEventFunction = function(dt)
            self.frameCount = self.frameCount + 1
            if self.fightFinish == true then
                if self.frameCount > 10 then
                    local cmdStr = self.curFight["c" .. tostring(self.curCmdIndex)]
                    
                    if cmdStr == nil or cmdStr == "" then 
                        self:removeAllNodeEventListeners()
                        self:unscheduleUpdate()
                        self:fightOver(dt)
                    else
                        self.curCmd:reSet(cmdStr)

                        self.fightFinish = false
                        self.curCmdIndex = self.curCmdIndex + 1

                        ----startCmds-----
                        self:startCmds()
                        ------------------
                    end
                else
                    -- logf("self.frameCount => %d", self.frameCount)
                end
            else
                self:runCmds()
            end
        end

        self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, frameEventFunction)
    else
        logf(" 第 %d 场战斗，已经没战斗数据了 ",self.fightIdx)
    end
end
-- startCmds
function FightScene:startCmds()
    -- logf("startCmds( %d )", self.frameCount)
    ------------ startCmd -----------                        
    local isNpc = self.curCmd.isNpc
    local size = self.curCmd.size

    for i=1,size do
        self.isRunnerFinish[i] = false
        local action = self.curCmd.actions[i]
        self:startCmd( isNpc , action )
    end
    ---------------------------------
end
-- runCmds
function FightScene:runCmds()
    ------------- runCmd ------------
    local isNpc = self.curCmd.isNpc
    local size = self.curCmd.size
    for i=1,size do
        if self.isRunnerFinish[i] ~= true then
            local action = self.curCmd.actions[i]
            local result = self:runCmd(isNpc , action)
            if result == true then
                self:endCmd(isNpc, action)
                self.isRunnerFinish[i] = true
            end
        end
    end    
    ---------------------------------
    local count = 0
    for i=1,size do
        if self.isRunnerFinish[i] == true then
            count = count + 1
        end
    end    
    if count == size then
        -- log(" 战斗 结束 一次 ")
        self.frameCount = 1
        self.fightFinish = true
    end
end

--
--
--
function FightScene:findHurtHero(runnerID , isNpc , pos , attType , howmany)
    local behurts = nil

    if isNpc == 0 then
        behurts = self.npcHeros
        printf("run not npc")
    else
        --todo
        printf(" run npc ")
        behurts = self.playerHeros
    end
    local keys = table.keys(behurts)
    local kSize = #keys
    dump(keys)
    -- local size = #self.npcHeros
    printf("FightScene:findHurtHero size => %d", kSize)

    if attType == 1 then 
        for i=1,kSize do
            local hero = behurts[keys[i]]
            if hero.type == "animal" then
                logf("hero id => %d , pos => %d , attType => %d ",hero.id , hero.pos , hero.autoAttType)
            end
        end
        
    elseif attType == 2 then
            --todo

    end

end



function FightScene:findHero(runnerID, isNpc)
    if isNpc == 1 or isNpc == "1" or isNpc == true then
        return self.npcHeros[tostring(runnerID)]
    else
        return self.playerHeros[tostring(runnerID)]
    end
end

function FightScene:calculate( dt )
    log("FightScene:calculate()")
end

function FightScene:startCmd( isNpc , action )
    -- log(" startCmd ")
    local runner =  self:findHero(action.runnerID, isNpc)
    local attType = action.attType
    -- logf("FightScene:startCmd() attType => %d", attType)
    if attType == 1 or attType == "1" then
        local behurtInfo = action.behurtInfos[1]
        local hurtHero = self:findHero(behurtInfo.hurtID, behurtInfo.isNpc)
        local x, y = hurtHero:getPosition()
        -- logf("x => %d , y => %d", x ,y )
        runner:toFightPosition(x, y)

        runner:startCmd(action)        

    elseif attType == 2 or attType == "2" then
        runner:skill()
        -- log(" 技能来了 ")
        local hurtSize = action.hurtSize
        -- log("hurtSize => " .. tostring(hurtSize))
        for i=1, hurtSize do
            local behurtInfo = action.behurtInfos[i]
            local hurtHero = self:findHero(behurtInfo.hurtID, behurtInfo.isNpc)
            local x, y = hurtHero:getPosition()
            self:showFightHurt({
                x=x,
                y=y,
                hurt=behurtInfo.hurtValue,
                status=behurtInfo.hurtStatus,
                isNpc=behurtInfo.isNpc})

            local progress = hurtHero:hurt(behurtInfo.hurtValue)
            hurtHero:hurtAction()        
        end
    else

    end

end

function FightScene:runCmd( isNpc , action )

    local runner =  self:findHero(action.runnerID, isNpc)
    local attType = action.attType
    if attType == 1 or attType == "1" then
        return runner:runCmd(action)
    elseif attType == 2 or attType == "2" then
        if self.frameCount == 80 then
            return true
        end
    else

    end

    return false
end

function FightScene:endCmd( isNpc , action )
    logf("end cmd")

    local runner =  self:findHero(action.runnerID, isNpc)
    local attType = action.attType
    -- logf("FightScene:endCmd() attType => %d", attType)
    if attType == 1 or attType == "1" then

    elseif attType == 2 or attType == "2" then
             
    else

    end
    runner:endCmd()
    -- runner:resetPosition()
end

function FightScene:fightOver(dt)
    -- logf(" %d fight over !!! " , self.fightIdx)







    self.fightIdx = self.fightIdx + 1

    self:removeNpcForNextFight()
    if self.fightIdx == 4 then
        -- logf(" fight over !!! ")
        display.replaceScene(LoginScene.new())
        return
    end
    self:nextFight()
end

function FightScene:onEnter()

    self:scheduleUpdate()
    self.fightHandler = self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,handler(self, self.fight))
    
end

function FightScene:onExit()
 -- print(" FightScene onExit ")
end


   --  self.sprite:addNodeEventListener(cc.NODE_EVENT, function (event)  
   --     if event.name == "enter" then  
   --         print("enter")  
   --     elseif event.name == "exit" then  
   --         print("exit")  
   --     elseif event.name == "cleanup" then  
   --         print("+ cleanup + ")  
   --     elseif event.name == "enterTransitionFinish" then  
   --         print("enterTransitionFinish")  
   --     elseif event.name == "exitTransitionStart" then  
   --         print("exitTransitionStart")  
   --     end  
   -- end)

    -- function touchListener(event)
    --     local x, y, prevX, prevY = event.x, event.y, event.prevX, event.prevY
    --     dump(event)
    --     if event.name == "began" then
    --         print(" began x=>"..tostring(x) .. " , y=>"..tostring(y) .. " , prevX=>"..tostring(prevX) .. " , prevY=>" .. tostring(prevY))
    --     elseif event.name == "moved" then
    --         print(" moved x=>"..tostring(x) .. " , y=>"..tostring(y) .. " , prevX=>"..tostring(prevX) .. " , prevY=>" .. tostring(prevY))
    --     elseif event.name == "ended" then
    --         print(" ended x=>"..tostring(x) .. " , y=>"..tostring(y) .. " , prevX=>"..tostring(prevX) .. " , prevY=>" .. tostring(prevY))
    --     end
    --     return false
    -- end


    -- local layer = display.newLayer()
    -- self:addChild(layer)
    -- layer:setTouchEnabled(true)
    -- layer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
    -- layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
    --     local x, y, prevX, prevY = event.x, event.y, event.prevX, event.prevY
    --     if event.name == "began" then
    --         print("layer began")
    --     elseif event.name == "moved" then
    --         print("layer moved")
    --     elseif event.name == "ended" then
    --         print("layer ended")
    --     end
    --         return true
    --     end)



    -- local a = {}
    -- for i=1,10 do
    --     logf("%d => %s",i,tostring(a[tostring(i)]))
    --     a[tostring(i)] = true
    --     logf("%d => %s",i,tostring(a[tostring(i)]))
    -- end




