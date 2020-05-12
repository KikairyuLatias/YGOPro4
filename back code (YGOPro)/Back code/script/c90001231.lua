-- 北極光の馴鹿
function c90001231.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_HAND_SYNCHRO)
	e1:SetLabel(90001231)
	e1:SetValue(c90001231.synval)
	c:RegisterEffect(e1)
	--stat boost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c90001231.atkcon)
	e2:SetOperation(c90001231.atkop)
	e2:SetValue(c90001231.value)
	c:RegisterEffect(e2)
	--stat boost
	local e3=e2:Clone()
	e3:SetCondition(c90001231.atkcon2)
	e3:SetOperation(c90001231.atkop2)
	c:RegisterEffect(e3)
end

--use hand as material
function c90001231.synval(e,c,sc)
	if sc:IsRace(RACE_BEAST) and --c:IsNotTuner() 
		(not c:IsType(TYPE_TUNER) or c:IsHasEffect(EFFECT_NONTUNER)) and c:IsRace(RACE_BEAST) and c:IsLocation(LOCATION_HAND) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_HAND_SYNCHRO+EFFECT_SYNCHRO_CHECK)
		e1:SetLabel(90001231)
		e1:SetTarget(c90001231.synchktg)
		c:RegisterEffect(e1)
		return true
	else return false end
end
function c90001231.chk2(c)
	if not c:IsHasEffect(EFFECT_HAND_SYNCHRO) or c:IsHasEffect(EFFECT_HAND_SYNCHRO+EFFECT_SYNCHRO_CHECK) then return false end
	local te={c:GetCardEffect(EFFECT_HAND_SYNCHRO)}
	for i=1,#te do
		local e=te[i]
		if e:GetLabel()==90001231 then return true end
	end
	return false
end
function c90001231.synchktg(e,c,sg,tg,ntg,tsg,ntsg)
	if c then
		local res=tg:IsExists(c90001231.chk2,1,c) or ntg:IsExists(c90001231.chk2,1,c) or sg:IsExists(c90001231.chk2,1,c)
		return res,Group.CreateGroup(),Group.CreateGroup()
	else
		return true
	end
end

--stat boosting
function c90001231.value(e,c)
	return c:GetLevel()*100
end

function c90001231.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c90001231.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c90001231.value)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	sync:RegisterEffect(e1)
end

--stat boosting
function c90001231.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c90001231.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(c90001231.value)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	sync:RegisterEffect(e2)
end