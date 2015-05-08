


package.loaded["app.SystemIncludes"] = nil
require("app.SystemIncludes")

	uploadPath = device.writablePath .. "upf/"
	cc.FileUtils:getInstance():addSearchPath(uploadPath)
    cc.FileUtils:getInstance():addSearchPath("res/")




package.loaded["app.scenes.MainScene"] = nil
require("app.scenes.MainScene")

package.loaded["app.update.UpdateScene"] = nil
require("app.update.UpdateScene")



local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()

	-- 初始化配置

    -- self:enterScene("MainScene")
    display.replaceScene(UpdateScene.new())

end

return MyApp
