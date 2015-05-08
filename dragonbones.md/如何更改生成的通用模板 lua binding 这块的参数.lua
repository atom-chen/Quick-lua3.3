1. quick-3.3/cocos/scripting/lua-bindings/proj.ios_mac/cocos2d_lua_bindings.xcodeproj
打开，需要把lua_dragonbones_auto.app,lua_dragonbones_auto.hpp新导入一次。
并且在Build Settings的 User Header Search Paths添加$(SRCROOT)/../../../editor-support/dragonbones/renderer/cocos2d-x-3.x的搜索路径
并且 确保在 Build Rules 能搜到 dragonbones 的源文件

2. quick-3.3/build/cocos2d_libs.xcodeproj 打开。dragonbones目录需要重新导入，
并且在Build Settings的 User Header Search Paths添加$(SRCROOT)/../cocos/editor-support/dragonbones/renderer/cocos2d-x-3.x的搜索路径
并且 确保在 Build Rules 能搜到 dragonbones 的源文件，

