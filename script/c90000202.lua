-- Psychic Dragon Hangetsu
function c90000202.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000202.spcon)
	c:RegisterEffect(e1)
	--stat halving
end

--ss
function c90000202.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1)
end
function c90000202.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90000202.filter,tp,LOCATION_MZONE,0,nil)
	return g:GetClassCount(Card.GetCode)>=2
end
