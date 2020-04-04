--Goha City Limits

--this better lock off the outerzones
getseq=Card.GetSequence
function Card.GetSequence(c)
	local seq=getseq(c)
	if c:IsLocation(LOCATION_SZONE) then
		if seq==0 then seq=1 end
		if seq==4 then seq=3 end
	end
	return seq
end
getseq2=Card.GetSequence
function Card.GetSequence(c)
	local seq=getseq(c)
	if c:IsLocation(LOCATION_MZONE) then
		if seq==0 then seq=1 end
		if seq==4 then seq=3 end
	end
	return seq
end

--code
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--skip standby phase
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SKIP_SP)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--skip main phase 2
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SKIP_M2)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetTargetRange(1,0)
	c:RegisterEffect(e3)
	--Activate
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SUMMON)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCost(s.cost1)
	e4:SetTarget(s.target1)
	e4:SetOperation(s.activate1)
	c:RegisterEffect(e4)
	--instant
	local e4a=Effect.CreateEffect(c)
	e4a:SetDescription(aux.Stringid(id,0))
	e4a:SetCategory(CATEGORY_SUMMON)
	e4a:SetType(EFFECT_TYPE_QUICK_O)
	e4a:SetRange(LOCATION_SZONE)
	e4a:SetCode(EVENT_FREE_CHAIN)
	e4a:SetCondition(s.condition2)
	e4a:SetCost(s.cost2)
	e4a:SetTarget(s.target2)
	e4a:SetOperation(s.activate2)
	c:RegisterEffect(e4a)
	--cannot use 2 monster zones
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE,LOCATION_MZONE)
	e5:SetCode(EFFECT_USE_EXTRA_MZONE)
	e5:SetValue(2)
	c:RegisterEffect(e5)
	--cannot use 2 backrow zones
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_SZONE,LOCATION_SZONE)
	e6:SetCode(EFFECT_USE_EXTRA_SZONE)
	e6:SetValue(2)
	c:RegisterEffect(e6)
end

--normal summon without restriction
function s.filter(c)
	return c:IsSummonable(true,nil) or c:IsMSetable(true,nil)
end
function s.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(0)
	local tn=Duel.GetTurnPlayer()
	local ph=Duel.GetCurrentPhase()
	if ((tn==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)) or (tn~=tp and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE))
			and Duel.CheckLPCost(tp,0)
			and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.PayLPCost(tp,0)
		e:SetLabel(1)
	end
end
function s.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetLabel()~=1 then return end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function s.activate1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if e:GetLabel()~=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if tc:IsSummonable(true,nil) and (not tc:IsMSetable(true,nil) 
			or Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)==POS_FACEUP_ATTACK) then
			Duel.Summon(tp,tc,true,nil)
		else Duel.MSet(tp,tc,true,nil) end
	end
end
function s.condition2(e,tp,eg,ep,ev,re,r,rp)
	local tn=Duel.GetTurnPlayer()
	local ph=Duel.GetCurrentPhase()
	return (tn==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)) or (tn~=tp and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
end
function s.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,0)
	else Duel.PayLPCost(tp,0) end
end
function s.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not e:GetHandler():IsStatus(STATUS_CHAINING) then
			local ct=Duel.GetMatchingGroupCount(s.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
			e:SetLabel(ct)
			return ct>0
		else return e:GetLabel()>0 end
	end
	e:SetLabel(e:GetLabel()-1)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function s.activate2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local s1=tc:IsSummonable(true,nil)
		local s2=tc:IsMSetable(true,nil)
		if (s1 and s2 and Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)==POS_FACEUP_ATTACK) or not s2 then
			Duel.Summon(tp,tc,true,nil)
		else
			Duel.MSet(tp,tc,true,nil)
		end
	end
end