
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end



function log( msg )
	print("-log- " .. msg)
end

function logf( fmt , ... )
	print("-log- " .. string.format(fmt, ...))
end


package.path = package.path .. ";src/"
cc.FileUtils:getInstance():setPopupNotify(false)

require ("app.systemincludes")


require("app.MyApp").new():run()
-- require ("UpdateScene")


-- updateScene()










