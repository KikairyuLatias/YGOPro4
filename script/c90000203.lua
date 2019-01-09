-- Psychic Dragon Kitana
function c90000203.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000203.spcon)
	c:RegisterEffect(e1)
	--destroy when used as material
end

--ss
function c90000203.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1) and not c:IsCode(90000203)
end
function c90000203.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000201.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end


