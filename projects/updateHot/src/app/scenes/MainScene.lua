
MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	    cc.ui.UILabel.new({
            UILabelType = 2, text = "更新之前", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
end
function MainScene:onEnter()
	self:schedule(function ( ... )
		-- body
		display.replaceScene(UpdateScene.new())
	end, 3)

	-- local schedule = require("framework.scheduler")
	-- schedule.performWithDelayGlobal(function(event)
	-- 	display.replaceScene(UpdateScene.new())
	-- end, 3)

end

function MainScene:onExit()
	
end

-- return MainScene
