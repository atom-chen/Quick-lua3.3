--
-- Author: wzg
-- Date: 2015-02-07 19:46:55
--
--   心跳30秒为最佳
--
--
require("pack")
local net = require("framework.cc.net.init")


MyNet = class("MyNet")

function MyNet:ctor()
    self:init()
	self.buffer = PacketBuffer.new()
    self.count = 1
end

function MyNet:init()
	local time = net.SocketTCP.getTime()
	print("socket time:" .. time)

	local socket = net.SocketTCP.new()
	socket:setName("MyNet")
	socket:setTickTime(0.5)
	socket:setReconnTime(5)
	socket:setConnFailTime(4)


	socket:addEventListener(net.SocketTCP.EVENT_DATA, handler(self, self.receveTcpData))
	socket:addEventListener(net.SocketTCP.EVENT_CLOSE, handler(self, self.tcpCloseCallback))
	socket:addEventListener(net.SocketTCP.EVENT_CLOSED, handler(self, self.tcpClosedCallback))
	socket:addEventListener(net.SocketTCP.EVENT_CONNECTED, handler(self, self.tcpConnectedCallback))
	socket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, handler(self, self.tcpConnectedFailCallback))

	self.socket_ = socket
end

function MyNet:Connect()
	self.socket_:connect("127.0.0.1", 9988, true)
end

function MyNet:SendData()
	self.socket_:send(string.format("send [%d] data", self.count))
	self.count = self.count + 1
end

function MyNet:Close()
	if self.socket_.isConnected then
		self.socket_:close()
	end
end

function MyNet:receveTcpData(event)
	self.buffer:parsePackets( event.data )

	print("SocketTCP 接收数据 ----- " .. event.data)
end


function MyNet:tcpCloseCallback()
	print("SocketTCP close")
end


function MyNet:tcpClosedCallback()
	print("SocketTCP closed")
end

function MyNet:tcpConnectedCallback()
	print("SocketTCP connect success")
end

function MyNet:tcpConnectedFailCallback()
	print("SocketTCP connect fail")
end

function MyNet:onExit()
	if self.socket_.isConnected then
		self.socket_:close()
	end
	self.socket_:disconnect()
end


