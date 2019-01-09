-- Diver Deer Underwater Training
function c90001119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90001119.tg)
	e2:SetValue(c90001119.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetValue(c90001119.val2)
	c:RegisterEffect(e3)
	--special summoning
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,90001119)
	e4:SetTarget(c90001119.target)
	e4:SetOperation(c90001119.activate)
	c:RegisterEffect(e4)
	--recycle links?
end

--boost
function c90001119.tg(e,c)
	return c:IsSetCard(0x4af) and c:IsType(TYPE_MONSTER)
end
function c90001119.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af)
end
function c90001119.val(e,c)
	return Duel.GetMatchingGroupCount(c90001119.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c90001119.val2(e,c)
	return Duel.GetMatchingGroupCount(c90001119.filter,c:GetControler(),0,LOCATION_MZONE,nil)*200
end
--ss condition
function c90001119.filter2(c)
	return c:IsSetCard(0x4af) and c:IsType(TYPE_MONSTER) and c:GetLevel()<=4
end
function c90001119.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001119.filter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c90001119.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001119.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
