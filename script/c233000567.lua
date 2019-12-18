--Hazmanimal Biodomain
local s,id=GetID()
function s.initial_effect(c)
	c:EnableCounterPermit(0x43a)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(s.ctcon)
	e2:SetOperation(s.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--add counter
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_FZONE)
	e4:SetOperation(aux.chainreg)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetCode(EVENT_CHAIN_SOLVING)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_FZONE)
	e5:SetOperation(s.ctop2)
	c:RegisterEffect(e5)
	--atk up
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetRange(LOCATION_FZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetValue(s.val)
	e6:SetTarget(s.hztg)
	c:RegisterEffect(e6)
	--atk up
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_UPDATE_DEFENSE)
	e7:SetRange(LOCATION_FZONE)
	e7:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e7:SetValue(s.val)
	e7:SetTarget(s.hztg)
	c:RegisterEffect(e7)
	--damage
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_LEAVE_FIELD_P)
	e8:SetOperation(s.damp)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e9:SetCategory(CATEGORY_DAMAGE)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetCode(EVENT_DESTROY)
	e9:SetTarget(s.damtg)
	e9:SetOperation(s.damop)
	e9:SetLabelObject(e8)
	c:RegisterEffect(e9)
end

--counter addition for summoning
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x43a)
end
function s.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil)
end
function s.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x43a,1)
end

--counter addition 2
function s.ctop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x43a) and e:GetHandler():GetFlagEffect(1)>0 then
		e:GetHandler():AddCounter(0x43a,1)
	end
end

--drop
function s.val(e)
	return e:GetHandler():GetCounter(0x43a)*-100
end
--boost
function s.hztg(e,c)
	return not c:IsSetCard(0x43a) and c:IsType(TYPE_MONSTER)
end

--damage
function s.damp(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(e:GetHandler():GetCounter(0x43a))
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabelObject():GetLabel()
	if chk==0 then return ct~=0 end
	local p=PLAYER_ALL
	Duel.SetTargetPlayer(p)
	Duel.SetTargetParam(ct*200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,ct*200)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if p==PLAYER_ALL then
		Duel.Damage(1,d,REASON_EFFECT,true)
		Duel.Damage(0,d,REASON_EFFECT,true)
		Duel.RDComplete()
	else
		Duel.Damage(p,d,REASON_EFFECT)
	end
end