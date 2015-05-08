

-- require ("app.systemincludes")
require ("app.appincludes")


local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()

	-- cc.Director:getInstance():getScheduler():setTimeScale(8)

	
    cc.FileUtils:getInstance():addSearchPath("res/")

    display.replaceScene(MainScene.new())
end

return MyApp


