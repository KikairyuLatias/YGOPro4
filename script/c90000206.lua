-- Psychic Dragon Emperor
function c90000206.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000206.spcon)
	c:RegisterEffect(e1)
	--cannot target for attacks
	--life boosting
end

--ss
function c90000206.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1)
end
function c90000206.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90000206.filter,tp,LOCATION_MZONE,0,nil)
	return g:GetClassCount(Card.GetCode)>=3
end
