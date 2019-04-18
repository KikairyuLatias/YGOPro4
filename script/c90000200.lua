--Sanctuary of the Eon Dragon
function c90000200.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk boost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000200.tg)
	e2:SetValue(c90000200.val)
	c:RegisterEffect(e2)
	--def boost
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90000200.target)
	e4:SetOperation(c90000200.activate)
	c:RegisterEffect(e4)
	--restrict from chaining to Psychic Dragons
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c90000200.chainop)
	c:RegisterEffect(e5)
	--act limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_SUMMON_SUCCESS)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c90000200.limcon)
	e6:SetOperation(c90000200.limop)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e7)
	local e8=e6:Clone()
	e8:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EVENT_CHAIN_END)
	e9:SetOperation(c90000200.limop2)
	c:RegisterEffect(e9)
end

--Psychic Dragon power up
function c90000200.tg(e,c)
	return c:IsSetCard(0x5f1) and c:IsType(TYPE_MONSTER)
end
function c90000200.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1)
end
function c90000200.val(e,c)
	return Duel.GetMatchingGroupCount(c90000200.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*200
end

-- spsummon
function c90000200.filter2(c)
	return c:IsSetCard(0x5f1) and c:IsType(TYPE_MONSTER)
end
function c90000200.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000200.filter2,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
end
function c90000200.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000200.filter2,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

--stop chaining
function c90000200.indval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c90000200.chainop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsSetCard(0x5f1) then
		Duel.SetChainLimit(c90000200.chainlm)
	end
end
function c90000200.chainlm(e,rp,tp)
	return tp==rp
end
function c90000200.limfilter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c90000200.limcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c90000200.limfilter,1,nil,tp) and re:IsSetCard(0x5f1)
end
function c90000200.limop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(c90000200.chainlm)
	elseif Duel.GetCurrentChain()==1 then
		e:GetHandler():RegisterFlagEffect(90000200,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c90000200.limop2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetOverlayCount()>0 and e:GetHandler():GetFlagEffect(90000200)~=0 then
		Duel.SetChainLimitTillChainEnd(c90000200.chainlm)
	end
	e:GetHandler():ResetFlagEffect(90000200)
end
function c90000200.chainlm(e,rp,tp)
	return tp==rp
end