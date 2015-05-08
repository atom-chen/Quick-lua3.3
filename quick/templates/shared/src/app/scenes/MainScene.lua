
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.ui.UILabel.new({
            UILabelType = 2, text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)

display.newColorLayer(cc.c4b(200, 200, 200,200)):addTo(self)

local factory = db.DBCCFactory:getInstance()
dump(factory)
   factory:loadDragonBonesData("armatures/Knight/skeleton.xml", "knight");
   factory:loadTextureAtlas("armatures/Knight/texture.xml", "knight");


for i=1,100 do
local dbnode = factory:buildArmatureNode("knight")
local t = i % 2
if t == 0 then 
dbnode:getAnimation():gotoAndPlay("stand")
elseif t == 1 then
	--todo
	dbnode:getAnimation():gotoAndPlay("run")
end

dbnode:addTo(self):align(display.CENTER, i % 10 * 90 + 50, i / 10 * 50 + 50)
end
    
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
