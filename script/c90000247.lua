--Number 26: Psychic Dragon Supreme Emperor Ryukyu
function c90000247.initial_effect(c)
	--xyz
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsSetCard,0x5f1),8,2)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.xyzlimit)
	c:RegisterEffect(e1)
	--burn and boost
	--revive and banish the opponent GY
end
c90000247.xyz_number=26