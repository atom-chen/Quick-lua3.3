

LoginScene = class("LoginScene", function()
    return display.newScene("LoginScene")
end)

function LoginScene:ctor()
	print("LoginScene ctor()")

   	self.label = cc.ui.UILabel.new({
            UILabelType = 2, text = "Login Scene", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
end

function LoginScene:onEnter()
	print(" LoginScene onEnter ")


	-- local scheduler  = require("framework.scheduler")
	-- self.handle = scheduler.performWithDelayGlobal( function (dt)
	-- 	display.replaceScene(FightScene.new())
	-- end, 2) 

        -- local frameEventFunction = function(dt)
        --     self.frameCount = self.frameCount + 1
        --     if self.fightFinish == true then
        --         if self.frameCount > 10 then
        --             local cmdStr = self.curFight["c" .. tostring(self.curCmdIndex)]
                    
        --             if cmdStr == nil or cmdStr == "" then 
        --                 self:removeAllNodeEventListeners()
        --                 self:unscheduleUpdate()
        --                 self:fightOver(dt)
        --             else
        --                 self.curCmd:reSet(cmdStr)

        --                 self.fightFinish = false
        --                 self.curCmdIndex = self.curCmdIndex + 1

        --                 ----startCmds-----
        --                 self:startCmds()
        --                 ------------------
        --             end
        --         else
        --             -- logf("self.frameCount => %d", self.frameCount)
        --         end
        --     else
        --         self:runCmds()
        --     end
        -- end

        -- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, frameEventFunction)

end


function LoginScene:onExit()
	print(" LoginScene onExit ")
end

