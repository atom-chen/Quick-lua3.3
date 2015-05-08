--
-- Author: wzg
-- Date: 2038-01-05 11:29:27
--

require("lfs")

IP = "192.168.1.114"
PORT = "8080"

local NEEDUPDATE = true

local updateServer = "http://" .. IP .. ":" .. PORT .. "/XDServer/flist"
local server = "http://" .. IP .. ":" .. PORT .. "/XDServer/"
local param = "?dev="..device.platform
local list_filename = "flist"
local downList = {}

local fileutil = cc.FileUtils:getInstance()

print("update path => " .. uploadPath)
local versionInfo = nil

local srcPath = cc.FileUtils:getInstance():fullPathForFilename("src")
print("srcPath => " .. tostring(srcPath))

local function checkFile(fileName, cryptoCode)
    print("checkFile:", fileName)
    print("cryptoCode:", cryptoCode)

    if not io.exists(fileName) then
        return false
    end

    local data=readFile(fileName)
    if data==nil then
        return false
    end

    if cryptoCode==nil then
        return true
    end

    local ms = crypto.md5(hex(data))
    print("file cryptoCode:", ms)
    if ms==cryptoCode then
        return true
    end

    return false
end

local function hex(s)
 s=string.gsub(s,"(.)",function (x) return string.format("%02X",string.byte(x)) end)
 return s
end

local function removeFile(path)
    --CCLuaLog("removeFile: "..path)
    io.writefile(path, "")
    if device.platform == "windows" then
        --os.execute("del " .. string.gsub(path, '/', '\\'))
    else
        os.execute("rm " .. path)
    end
end

local function checkDirOK( path )
        require "lfs"
        local oldpath = lfs.currentdir()
        CCLuaLog("old path------> "..oldpath)

         if lfs.chdir(path) then
            lfs.chdir(oldpath)
            CCLuaLog("path check OK------> "..path)
            return true
         end

         if lfs.mkdir(path) then
            CCLuaLog("path create OK------> "..path)
            return true
         end
end

function os.exists(path)
    return cc.FileUtils:getInstance():isFileExist(path)
end

function os.mkdir(path)
    if not os.exists(path) then
        return lfs.mkdir(path)
    end
    return true
end

function os.rmdir(path)
    -- print("os.rmdir:", path)
    if os.exists(path) then
        local function _rmdir(path)
            local iter, dir_obj = lfs.dir(path)
            while true do
                local dir = iter(dir_obj)
                if dir == nil then break end
                if dir ~= "." and dir ~= ".." then
                    local curDir = path..dir
                    local mode = lfs.attributes(curDir, "mode") 
                    if mode == "directory" then
                        _rmdir(curDir.."/")
                    elseif mode == "file" then
                        os.remove(curDir)
                    end
                end
            end
            local succ, des = os.remove(path)
            if des then print(des) end
            return succ
        end
        _rmdir(path)
    end
    return true
end

local function createDownloadDir(path)
    local mkdirResult = os.mkdir(path)
    printf("创建目录%s 是否成功：%s", path, tostring(mkdirResult))
end

-- local 
UpdateScene = class("UpdateScene", function()
    return display.newScene("UpdateScene")
end)

function UpdateScene:ctor()
    self.label = cc.ui.UILabel.new({
            UILabelType = 2, text = "update, scene", size = 64})

    self.label:align(display.CENTER, display.cx, display.cy)
        :addTo(self)

    self.dataRecv = nil
    self.index = 1
    -- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt) self:onEnterFrame(dt) end)
end

function UpdateScene:updateF( idx )
    local t = server .. self.updateFiles[self.index].name

    printf("to server updateF %d => %s", self.index , t)

    local request = network.createHTTPRequest(function(event)
        if tolua.isnull(self) then
            printf("REQUEST COMPLETED, BUT SCENE HAS QUIT", 1)
            return
        end
        self:onResponse(event, self.index , "update")
    end, t, "GET")

    request:start()
    -- self.index = self.index + 1
end

function UpdateScene:onEnter()
	print("update Scene onEnter()")

    self.oldListFile =  uploadPath..list_filename               
    self.fileList = nil
    if io.exists(self.oldListFile) then
        print("exists => " .. self.oldListFile)
        self.fileList = dofile(self.oldListFile)
    end
    if self.fileList==nil then
        self.fileList = {
            vCode = 1,
            ver = "1.0.0"
        }
    end
    dump(self.fileList)

    local result = os.mkdir(uploadPath)
    print( "make update dir result => " .. tostring(result))

    local request = network.createHTTPRequest(function(event)
        if tolua.isnull(self) then
            printf("REQUEST %d COMPLETED, BUT SCENE HAS QUIT", self.index)
            return
        end
        self:onResponse(event, self.index, "version")
    end, updateServer, "GET")

    request:start()

end

function UpdateScene:onVersion()
    print("updateScene() onVersion(dt)")
    if self.dataRecv then

        io.writefile(self.oldListFile, self.dataRecv)

        self.newfileList = dofile(self.oldListFile)

        local oc = 1 --checkint( self.fileList.vCode )
        local nc = checkint( self.newfileList.vCode )
        if nc > oc then
            local updateRemoveFile = self.newfileList.remove
            local size = #updateRemoveFile
            for i=1,size do
                local path = updateRemoveFile[i].path
                local aa = fileutil:fullPathForFilename(path)
                printf("remove item : %s => %s", path,aa)
                os.remove(aa)
            end
            
            self.updateFiles = self.newfileList.add
            self:updateF()
        end

        self.dataRecv = nil

    end
end

function UpdateScene:onUpdatedF()
    print("updateScene() onUpdatedF(dt)")
    if self.dataRecv then

        local md5 = crypto.md5(self.dataRecv)
        printf("%s md5 => %s" ,  self.updateFiles[self.index].path, md5)

        if md5 ~= self.updateFiles[self.index].md5 then
            self.label:setString("下载失败,文件数据丢失，md5校验失败")
            return
            -- display.replaceScene(MainScene.new())
        end

        local savePath = self.updateFiles[self.index].path

        printf(" download after %d savePath => %s " , self.index, savePath)
        
        savePath = uploadPath .. savePath

        local b = string.split(savePath, "/")
        local dir = b[1]
        for i = 2 , #b-1 do
            dir = string.format("%s/%s", dir,b[i])
            -- print("dir => " .. dir)
            local result = createDownloadDir(dir)
        end
    

        printf(" download after %d savePath => %s " , self.index, savePath)
        -- dump(self.dataRecv)
        local result = io.writefile(savePath, self.dataRecv)

        print("是否写入成功" .. tostring(result))

        self.dataRecv = nil
        
        self.index = self.index + 1
        local size = #self.updateFiles
        if self.index > size then
            print("更新完了")

            cc.LuaLoadChunksFromZIP("update.zip")

            package.loaded["app.scenes.MainScene"] = nil
            require("app.scenes.MainScene")
            display.replaceScene(MainScene.new())

        else
            --todo
            self:updateF(self.index)
        end


    else
            --todo
            --    self.dataRecv = nil
        self.label:setString(string.format("update file %d 数据为空", self.index ))

    end

end


function UpdateScene:onResponse(event, index, _type)

    local request = event.request
    -- printf("REQUEST %d - event.name = %s", index, event.name)
    if event.name == "completed" then

        self.label:setString( "100%" )

        if request:getResponseStatusCode() ~= 200 then
            self:endProcess()
        else
            printf("REQUEST %d - getResponseDataLength() = %d", index, request:getResponseDataLength())

            self.dataRecv = request:getResponseData()

            if _type == "version" then
                self:onVersion()
            elseif _type == "update" then
                --todo
                self:onUpdatedF()
            end

        end
    elseif event.name == "progress" then
        local progr = checkint( event.dltotal / event.total * 100 )
        self.label:setString( string.format("%d %%", progr) )
    elseif event.name == "failed" then
        self.label:setString( "连接失败" )

    end

    -- print("----------------------------------------")
end


function UpdateScene:endProcess()
    print("----------------------------------------UpdateScene:endProcess")

            -- if self.fileList and self.fileList.stage then
            --     local checkOK = true
            --     for i,v in ipairs(self.fileList.stage) do
            --         if not checkFile(self.path..v.name, v.code) then
            --             CCLuaLog("----------------------------------------Check Files Error")
            --             checkOK = false
            --             break
            --         end
            --     end

            --     if checkOK then
            --         for i,v in ipairs(self.fileList.stage) do
            --             if v.act=="load" then
            --                 cc.LuaLoadChunksFromZIP(self.path..v.name)
            --             end
            --         end
            --         for i,v in ipairs(self.fileList.remove) do
            --             removeFile(self.path..v)
            --         end
            --     else
            --         removeFile(self.curListFile)
            --     end
            --   end

            -- require("appentry")
end



function UpdateScene:onExit()
	print("update Scene onExit()")
end

-- return UpdateScene
