--
-- Author: wzg
-- Date: 2014-12-23 11:01:45
--
Hero = class("Hero", function()
    return display.newNode()
end)

function Hero:ctor(initHeroData)
    -- log("#########################################")
    self.bg = display.newSprite("fight/hero_bg.png")
        :align(display.CENTER, 10, -89)
        :addTo(self,0)
        :scale(1.3)
    self.sprite = ccs.Armature:create(initHeroData.hero)            
    local function animationEvent(armatureBack,movementType,movementID)
        local id = movementID
        if movementType == ccs.MovementEventType.loopComplete then
            -- todo
        elseif movementType == ccs.MovementEventType.complete then
            if movementID == "attack" or movementID == "hurt" then
                self.sprite:setColor(cc.c3b(255, 255, 255))
                self.sprite:getAnimation():play("wait")
            end
            if movementID == "attack" then
                self.isFinish = true
            end
        end
    end

    self.sprite:getAnimation():setMovementEventCallFunc(animationEvent)
    local function onFrameEvent( bone,evt,originFrameIndex,currentFrameIndex)
        if evt == "att" then
            local behurtInfo = self.curAction.behurtInfos[1]

            local hurtHero = self.fightScene:findHero(behurtInfo.hurtID, behurtInfo.isNpc)
            local x, y = hurtHero:getPosition()

            self.fightScene:showFightHurt({
                x=x,
                y=y,
                hurt=behurtInfo.hurtValue,
                status=behurtInfo.hurtStatus,
                isNpc=behurtInfo.isNpc})

            hurtHero:hurt(behurtInfo.hurtValue)
            hurtHero:hurtAction()
        end
    end

    self.sprite:getAnimation():setFrameEventCallFunc(onFrameEvent)
    self.sprite:getAnimation():play("wait")
    self.sprite:setPosition(0, 50)    
    self:addChild(self.sprite,1,1)

    self.isNpc = initHeroData.isNpc
    if initHeroData.isNpc == 0 or initHeroData.isNpc == "0" then 
        self.sprite:setScaleX(-1)
        self.curTime = 70
    else
        self.curTime = 0
    end

    self.actionCount = 0   -- 当前运动条满
    self.needResetPosition = "false"
    self.id = initHeroData.id    -- 编号 
    self.type = initHeroData.type    -- 类型，宠物animal或是人物hero
    self.life=initHeroData.life      -- 血值
    self.curLife = initHeroData.life -- 当前血值
    self.icon = initHeroData.icon    -- icon
    self.attHurt = initHeroData.attHurt -- 普攻伤害 
    self.skiHurt = initHeroData.skiHurt  -- 技能伤害
    self.actionTime = initHeroData.actionTime -- 每次运行条增长值
    self.autoAttType = initHeroData.autoAttType -- 自动战斗的时候是普攻还是技能1普攻。2技能攻
    self.pos = initHeroData.pos        -- 站位
    -- log("#########################################")
end


function Hero:addActionTime()
    -- body
    self.curTime = self.curTime + self.actionTime
    if self.curTime >= 100 then
        self.curTime = self.curTime - 100
        self.actionCount = self.actionCount + 1
    end
    
end

function Hero:savePosition()
    -- body
    self.ox = self:getPositionX()
    self.oy = self:getPositionY()
    self.oz = self:getLocalZOrder()
    -- logf("ox => %d , oy => %d , oz => %d .", self.ox, self.oy , self.oz) 
    
end

function Hero:isDeaded()
    if self.curLife <= 0 then
        return true
    end
    return false
end

function Hero:startCmd(action)
    self.curAction = action
    self.isFinish = false
end
function Hero:runCmd(action)
    return self.isFinish
end
function Hero:endCmd()
    self:resetPosition()
    self.curAction = nil
    self.isFinish = false
end


function Hero:hurt(hurtValue)
    local progress = 100
    self.curLife = self.curLife - hurtValue
    if self.curLife <= 0 then
        logf(" Hero id = %d , pos => %d , is dead.",self.id,self.pos)

        self.curLife = 0
        local fadeTime = 0.75
        self.sprite:runAction(cc.FadeOut:create(fadeTime))
        -- self.bg:runAction(cc.FadeOut:create(fadeTime))

        if self.isNpc == "0" or self.isNpc == 0 then
            self.icon:zorder(0)
        end
        progress = 0
    else

    end
    local t1 = self.curLife / self.life * 100
    progress = checkint(t1)
    -- logf(" Hero.id = %d , t1 => %f , progress -> %d.",self.id , t1,progress)

    if self.isNpc == "0" or self.isNpc == 0 then
        self.hp:runAction(progressTo_(1,progress))
    end

    return progress
end

function Hero:toFightPosition( x , y )
    if x and y then
        self:savePosition()
        self.needResetPosition = "true"

        -- logf(" %d , Hero:toFightPosition( %d , %d )  , self.needResetPosition => " .. tostring(self.needResetPosition) , self.id , x,y)

        if self.isNpc == 1 or self.isNpc == "1" then
            self:setPosition(x + 110, y)
        else
            self:setPosition(x - 110, y)
        end

        local z = display.height - y
        self:zorder(z + 1)
        self:attack()
    end
end

function Hero:attack()
    self.sprite:setColor(cc.c3b(255, 255, 255))
    self.sprite:getAnimation():play("attack")
end
function Hero:waitAction()
    -- self.sprite:setColor(cc.c3b(255, 255, 255))
    self.sprite:getAnimation():play("wait")
end
function Hero:moveAction()
    self.sprite:getAnimation():play("move")
end
function Hero:hurtAction()
    self.sprite:setColor(cc.c3b(168, 0, 0))
    self.sprite:getAnimation():play("hurt")
end
function Hero:skill()
    self.sprite:runAction(cc.JumpBy:create(0.5, cc.p(0,0), 80, 1))
end

function Hero:resetPosition()
    if self.needResetPosition == "true" then
        self.needResetPosition = "false"
        self:setPosition(self.ox, self.oy)
        self:zorder(self.oz)
    end
end

function Hero:addBeforeEffect()
    -- body
    log(" 添 加 前 景 光 效 ")
end

function Hero:addAffterEffect()
    -- body
    log(" 添 加 后 景 光 效 " )
end

function Hero:onEnter()
	print(" Hero onEnter ")
end

function Hero:onExit()
	print(" Hero onExit ")
end
