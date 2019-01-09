-- Snow Flyer - Donner
function c90001208.initial_effect(c)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90001208.target)
	c:RegisterEffect(e2)
end
function c90001208.target(e,c)
	return c:IsSetCard(0x14c9)
end
