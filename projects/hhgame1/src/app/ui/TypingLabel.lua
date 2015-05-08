
TypingLabel = class("TypingLabel",function(params)
    return display.newTTFLabel(params)
end)
--     sample
    -- TypingLabel.new({
    --     text = "黄巾abc贼兵就在215前方，我们快追！！！",
    --     font = FONT_NAME,
    --     size = 34,
    --     color = cc.c3b(255, 255, 255), -- 使用纯红色
    --     align = cc.TEXT_ALIGNMENT_LEFT,
    --     valign = cc.VERTICAL_TEXT_ALIGNMENT_TOP,
    --     dimensions = cc.size(700, 300),
    --     finishCall = function() 
    --         printf("打印结束 ")
    --     end
    -- }):align(display.CENTER, display.cx, display.cy-100)
    --     :addTo(self)

function TypingLabel:ctor(params)
    
    cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
    self:setNodeEventEnabled(true)
    self:setTouchEnabled(true)

    self._text = params.text
    self._curIndex = 0
    
    self._finishCall = params.finishCall

    self:setString("")
    self:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
        if event.name == "ended" then
            if self._curIndex <= string.utf8len(self._text) then
                self:setString(self._text)
                self._curIndex = string.utf8len(self._text) + 1
            end
            if self._updateEntry then
                self._finishCall()
                cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._updateEntry)
                self._updateEntry = nil
            end
        end
            return true
    end)

end

-- function TypingLabel:onTouch(event)
--     if event.name == "ended" then
--         if self._curIndex <= string.utf8len(self._text) then
--             self:setString(self._text)
--             self._finishCall()
--             self._curIndex = string.utf8len(self._text) + 1
--         end
--         printf("----------打印结束 ")
--         if self._updateEntry then
--             cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._updateEntry)
--             self._updateEntry = nil
--         end
--     end
--     return true
-- end

local function chsize(char)
    if not char then
        -- error
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end

local function utf8len(str)
    local len = 0
    local currentIndex = 1
    while currentIndex <= #str do
        local char = string.byte(str,currentIndex)
        currentIndex = currentIndex + chsize(char)
        len = len + 1
    end
    return len
end

local function utf8sub(str,startChar,numChars)
    local startIndex = 1
    while startChar > 1 do
        local char = string.byte(str,startIndex)
        startIndex = startIndex + chsize(char)
        startChar = startChar - 1
    end
    
    local currentIndex = startIndex
    
    while numChars > 0 and currentIndex <= #str do
        local char = string.byte(str,currentIndex)
        currentIndex = currentIndex + chsize(char)
        numChars = numChars - 1
    end
    
    return str:sub(startIndex,currentIndex - 1)
end

function TypingLabel:update(dt)
    self.dt = self.dt or 0
    self.dt = self.dt + dt
    if self.dt >= 150/1000 then
        self._curIndex = self._curIndex + 1
        local t = utf8sub(self._text,1,self._curIndex)
        self:setString(t)
        self.dt = 0
    end

    if self._curIndex > string.utf8len(self._text) then
        if self._updateEntry then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._updateEntry)
            self._updateEntry = nil
            self._finishCall()
        end
    end
end

function TypingLabel:onEnter()
    print("TypingLabel:onEnter()")
    self._updateEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update),0,false)
end

function TypingLabel:onExit()
    if self._updateEntry then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._updateEntry)
        self._updateEntry = nil
    end
end

-- return TypingLabel