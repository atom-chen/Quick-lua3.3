--
-- Author: wzg
-- Date: 2038-01-03 04:16:13
--
-- sample1 
-- local cmd = "1,1CMD1,1HS2_0_50_0HP2_0_50_0AS1,1HS2_0_50_0HP2_0_50_0"

Cmd = class("Cmd")
function Cmd:ctor(params)
	self._cmd = params
	self.actions = {}

	self:parseBase()
end

function Cmd:reSet(__cmd)
	self._cmd = __cmd
	-- dump(__cmd)
	self:parseBase()
end

function Cmd:parseBase()

	local split = string.split

	-- local c1 = string.split(self._cmd, "CMD")
	local c1 = split(self._cmd, "CMD")
    -- printf("cmd split size = > %d", #c1)
    -- for i=1,#c1 do
    --     printf(" cmd %d => %s" ,i , c1[i])
    -- end
-----------------------------------------------
    local p = split(c1[1], ",")
    self.isNpc = p[1]  ----  0 false ,  1 true
    self.size = checkint(p[2])
    -- logf("isNpc = %d , size => %d", self.isNpc,self.size)
-----------------------------------------------
   	local as = split(c1[2], "AS")

    -- printf("actions split size = > %d", #as)
    for i=1,#as do
		self.actions[i] = FightAction.new(as[i])
    end



-----------------------------------------------
-----------------------------------------------
end

function Cmd.buildCmd( _isNpc , _size , _beHurtInfos)

	local isNpc = _isNpc
	if _isNpc == true then
		isNpc = 1
	else
		isNpc = 0
	end

	local t = string.format("%s,%sCMD%s" , isNpc , _size , _beHurtInfos )
	return t
end

function Cmd.buildActions( _actionA , _actionB )
	local t = string.format("%sAS%s", _actionA , _actionB )
	return t
end


function Cmd.buildActionsWidthArray( _actions )
	local size = #_actions

	local t = _actions[1]

	for i=2,size do
		t = Cmd.buildActions(t, _actions[i])
	end

	return t
end





