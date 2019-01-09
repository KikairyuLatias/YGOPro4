--ＺＰＤ警察 − 「デルガド」
function c90000108.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90000108.target)
	c:RegisterEffect(e1)
end

function c90000108.target(e,c)
	return c:IsSetCard(0x4b0)
end
