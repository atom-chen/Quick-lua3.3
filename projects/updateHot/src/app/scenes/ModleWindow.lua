--
-- Author: wzg
-- Date: 2038-01-07 11:49:06
--
    -- sample
    --
    -- local window = require("app.scenes.ModleWindow").new({
    --     color = cc.c4b(0, 100, 0, 100),
    --     closeBtnCallback = function() print(" close button call back ....") end,
    --     okBtnCallback = function() print(" ok button call back ....") end,
    --     cancelBtnCallback = function() print(" cancel button call back ....") end,
    --    
    --     })
    -- window:addTo(self)
    --

local ModleWindow = class("ModleWindow", function()
	local color = cc.c4b(255, 100, 100, 100)
    return display.newColorLayer(color)
end)

function ModleWindow:ctor(params)
    cc.ui.UILabel.new({
            UILabelType = 2, text = "modle, window", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)

    local bgColor = params.color or cc.c4b(255, 100, 100, 100)
    self:setColor(bgColor)

	local border = display.newSprite("anouncement_bg.png"):center():addTo(self, 0, 0)

    self.closeBtnCallback = params.closeBtnCallback
	self.okBtnCallback = params.okBtnCallback
	self.cancelBtnCallback = params.cancelBtnCallback	

   	local okBtn =  cc.ui.UIPushButton.new({normal = "btn.png"})
    okBtn:onButtonClicked(function(event)
        if self.okBtnCallback then
        	self.okBtnCallback()
        end
        self:removeSelf()
    end)
        :onButtonPressed(function(event) okBtn:setScale(1.2) end)
        :onButtonRelease(function(event) okBtn:setScale(1) end)
        :addTo(border)
        :pos(100, 50)


   	local cancelBtn =  cc.ui.UIPushButton.new({normal = "btn.png"})
    cancelBtn:onButtonClicked(function(event)
        if self.okBtnCallback then
        	self.cancelBtnCallback()
        end
        self:removeSelf()
    end)
        :onButtonPressed(function(event) cancelBtn:setScale(1.2) end)
        :onButtonRelease(function(event) cancelBtn:setScale(1) end)
        :addTo(border)
        :pos(530, 50)


   	local closeBtn =  cc.ui.UIPushButton.new({normal = "btn.png"})
    closeBtn:onButtonClicked(function(event)
        if self.closeBtnCallback then
        	self.closeBtnCallback()
        end
        self:removeSelf()
    end)
        :onButtonPressed(function(event) closeBtn:setScale(1.2) end)
        :onButtonRelease(function(event) closeBtn:setScale(1) end)
        :addTo(border)
        :pos(590, 340)





    border:setTouchSwallowEnabled(true)
    border:setTouchEnabled(true)
    border:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return true
    end)

    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    	-- self:removeSelf()
        return true
    end)





  

		

end

function ModleWindow:onEnter()
end

function ModleWindow:onExit()
end

return ModleWindow
