--
-- Author: wzg
-- Date: 2014-12-26 16:39:42
--


Hurt = class("Hurt", function()
    return display.newNode()
end)

function Hurt:ctor(params)
    -- log("###### Hurt:ctor #######")
    local width , height =  14,20
    local label = newLabelAtlas(params.hurtNum, "fight/fightPowerNum.png", width, height, "0")

    local width1 = label:getBoundingBox().width

    local width2 = 0

    if params.status == 1 then
    	self.bj = display.newSprite("fight/bj.png")
    	width2 = width1 + self.bj:getBoundingBox().width
	end

    width2 = width2 / 2

    if params.status == 1 then
        label:align(display.CENTER_RIGHT, width2, 0):addTo(self)
        self.bj:align(display.CENTER_RIGHT, width2-width1, 0):addTo(self)
    else
        label:align(display.CENTER_RIGHT, width1 / 2, 0):addTo(self)
	end
    -- label:align(display.CENTER, display.cx, display.cy):addTo(self, 100, 100)
    -- log("#########################################")
end


-- function Hero:resetPosition()
--     -- body
--     log("1111111111 Hero:resetPosition() %%%%%%%%%% => " ..tostring(self.needResetPosition)  .. " ,  id => " .. tostring(self.id) )
--     -- self:setPosition(self.ox, self.oy)
--     if self.needResetPosition == "true" then
--         self.needResetPosition = "false"
--         log("2222222222 Hero:resetPosition() $$$$$$$$$$$$")
--         logf("3333333333 ox => %d , oy => %d", self.ox, self.oy) 
--         self:setPosition(self.ox, self.oy)
--     end
-- end

-- function Hero:onEnter()
-- 	print(" Hero onEnter ")
-- end

-- function Hero:onExit()
-- 	print(" Hero onExit ")
-- end



