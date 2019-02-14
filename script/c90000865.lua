--Phoenix Guardian - Assault Striker
function c90000865.initial_effect(c)
	--stat
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c90000865.val)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000865.target)
	c:RegisterEffect(e2)
end
--stat bonus
function c90000865.val(e,c)
	return Duel.GetMatchingGroupCount(c90000865.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end
function c90000865.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x641)
end
--piercing
function c90000865.target(e,c)
	return c:IsSetCard(0x641)
end
