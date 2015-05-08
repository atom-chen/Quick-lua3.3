
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

print("package.path => " .. tostring(package.path))

package.path = package.path .. ";src/"

print("package.path => " .. tostring(package.path))


local writablePath = cc.FileUtils:getInstance():getWritablePath()
uploadPath = writablePath .. "upf/"
cc.FileUtils:getInstance():addSearchPath(uploadPath,true)
cc.FileUtils:getInstance():addSearchPath("res/")




cc.FileUtils:getInstance():setPopupNotify(false)
require("app.MyApp").new():run()
