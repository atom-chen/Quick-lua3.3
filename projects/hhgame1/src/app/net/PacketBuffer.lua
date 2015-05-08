--
-- Author: wzg
-- Date: 2015-02-07 20:52:05
--

cc.utils = require("framework.cc.utils.init")
local ByteArray = cc.utils.ByteArray
local ByteArrayVarint = cc.utils.ByteArrayVarint

PacketBuffer = class("PacketBuffer")
-- 所有网络回调函数注册
NetCallBack = {}

function PacketBuffer:ctor()
    self:init()
	self.buffer = ByteArrayVarint.new(ByteArray.ENDIAN_BIG)
end

function PacketBuffer:init( )
	-- body
end

function PacketBuffer:parsePackets( byteString ) 

	self.buffer:setPos( self.buffer:getLen()+1 )
	self.buffer:writeBuf( byteString )
		:setPos(1)

	while true do

		print(" 解 析 packet ")

		local len = self.buffer:getLen()
		print("cur PacketBuffer len:", len )

		if len > 7 then

			local strData = self.buffer:toString(10)
			print("curr buffer bytes :", strData)
			local packetHead = self.buffer:readByte()
			print("read packetHead:", packetHead )

			local method_id = self.buffer:readShort()
			print("method_id :", method_id )

		    print("available:", self.buffer:getAvailable())
		    local size = self.buffer:readInt()

		    if len >= size + 7 and packetHead == 8 then

					print("msg len :", size )
					local msgData = self.buffer:readStringBytes( size )
					-- print(" msg readString:",  msgData)
				    
				    local available = self.buffer:getAvailable()
					print("available:", self.buffer:getAvailable())

					local netCallBack = NetCallBack[method_id]
					if netCallBack then
						netCallBack( msgData )
					else
						printf("ERROR net call back function is nil , method_id -> %d" , method_id)
					end
				    
				    local newB = ByteArrayVarint.new(ByteArray.ENDIAN_BIG)
				    local lastData = self.buffer:readBuf(available)
				    newB:writeBuf(lastData):setPos(1)
				    self.buffer = newB

			end

		else
			--todo
			return
		end

	end


end










































