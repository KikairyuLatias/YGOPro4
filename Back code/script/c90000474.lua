--Eclipse Dream Delphinite
function c90000474.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c90000474.lcheck)
	c:EnableReviveLimit()
	--special summon member
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000474,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c90000474.target)
	e2:SetOperation(c90000474.operation)
	c:RegisterEffect(e2)
	--zero battle damage with Eclipse Dream
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c90000474.efilter)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
--req
function c90000474.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x5f9)
end
--zero damage
function c90000474.efilter(e,c)
	return c:IsSetCard(0x5f9)
end
--ss condition
function c90000474.filter(c,e,tp)
	return c:IsSetCard(0x5f9) and c:IsAttackBelow(2400) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(90000474)
end
function c90000474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000474.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c90000474.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000474.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end