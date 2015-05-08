--
-- Author: wzg
-- Date: 2038-01-03 04:48:05
--

FightAction = class("FightAction")

function FightAction:ctor(params)
	self._action = params
	self.behurtInfos = {}

	self:parseBase()
end

function FightAction:reSet(__action)
	self._action = __action
	self:parseBase()
end

function FightAction:parseBase()
-----------------------------------------------
	-- logf("FightAction parseBase() , %s " , self._action)

	local split = string.split

    local t = split(self._action, "HS")
    -- for i=1,#t do
    --     printf(" action %d => %s" ,i , t[i])
    -- end

    local tr = split(t[1], ",")
    self.runnerID = tr[1]
    self.attType = tr[2]
    -- logf("runner => %d , attType => %d", self.runnerID, self.attType)

    local t1 = split(t[2], "HP")
    for i=1,#t1 do
    	self:parseHurt(i, t1[i])
    end
    self.hurtSize = #t1
    -- logf("hurtSize => %d", self.hurtSize)
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------


end

function FightAction:parseHurt( _idx , _hurtStr)

	-- logf("parseHurt()000000000000000")
	local hurtInfo = self.behurtInfos[_idx]
	if hurtInfo == nil then
		hurtInfo = {}
		self.behurtInfos[_idx] = hurtInfo
	end

	local p = string.split(_hurtStr, "_")
    hurtInfo.hurtID = p[1]
    hurtInfo.isNpc = p[2]
    hurtInfo.hurtValue = checkint( p[3] )                              
    hurtInfo.hurtStatus = checkint( p[4] )

end

function FightAction.buildHurtInfo( _hurtID ,_isNpc , _hurtValue , _hurtStatus)
	local t = string.format("%s_%s_%s_%s", _hurtID ,_isNpc , _hurtValue , _hurtStatus )
	return t
end

function FightAction.buildHurtInfoWidthObj( _hurtJson )
	local isNpc = _hurtJson.isNpc
	if isNpc == true then
		isNpc = 1
	else
		isNpc = 0
	end

	local t = string.format("%s_%s_%s_%s", _hurtJson.hurtID , isNpc , _hurtJson.hurtValue , _hurtJson.hurtStatus )
	return t
end


function FightAction.buildBeHurtInfos( _hurtInfoA , _hurtInfoB )
	local t = string.format("%sHP%s", _hurtInfoA , _hurtInfoB )
	return t
end

function FightAction.buildBeHurtInfosWidthArray( _hurtInfos )
	local size = #_hurtInfos

	local t = _hurtInfos[1]

	for i=2,size do
		t = FightAction.buildBeHurtInfos(t, _hurtInfos[i])
	end

	return t
end

function FightAction.buildAction(_runnerID , _attType , _beHurtInfos)
	local t = string.format("%s,%sHS%s" , _runnerID , _attType , _beHurtInfos)
	return t
end


    -- local cmd = "1,1CMD1,1HS2_0_50_0HP2_0_50_0         AS1,1HS2_0_50_0HP2_0_50_0"

