
--   示例
--   Sample to use 

-- ScaleButton.new({
--         image = "fight/auto.png",
--         listener = function(evet)
--             -- todo
--             log("我的按钮被点击了")
--         end,
--     })
--     :align(display.CENTER, display.cx, display.cy)
--     :addTo(self.menuLayer,10)
ScaleButton = {}

function ScaleButton.new(params)
    local listener = params.listener
    local button -- pre-reference

    params.listener = function(event)
        if params.prepare then
            params.prepare()
        end
        listener(event)
    end

    -- -- 点击后按钮固定放大的 Scale
    -- local BUTTON_SCALE = 1.2

    button =  cc.ui.UIPushButton.new({normal = params.image})
    button:onButtonClicked(function(event)
        params.listener(event)
    end)
        :onButtonPressed(function(event) button:setScale(BUTTON_SCALE) end)
        :onButtonRelease(function(event) button:setScale(1) end)
    return button
end




