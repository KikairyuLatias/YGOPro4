--Phoenix Cycle
function c90000876.initial_effect(c)
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
	e2:SetTarget(c90000876.tg)
	e2:SetValue(c90000876.val)
	c:RegisterEffect(e2)
	--def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(c90000876.val)
	e3:SetTarget(c90000876.tg)
	c:RegisterEffect(e3)
	--special summoning
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,90000876)
	e4:SetTarget(c90000876.target)
	e4:SetOperation(c90000876.activate)
	c:RegisterEffect(e4)
end
--boost
function c90000876.tg(e,c)
	return c:IsSetCard(0x641) and c:IsType(TYPE_MONSTER)
end
function c90000876.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x641)
end
function c90000876.val(e,c)
	return Duel.GetMatchingGroupCount(c90000876.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*200
end
--ss condition
function c90000876.filter2(c)
	return c:IsSetCard(0x641) and c:IsType(TYPE_MONSTER)
end
function c90000876.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000876.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c90000876.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000876.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end