--Resolution Fur Hire
function c90000508.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)	
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c90000508.indtg)
	e4:SetValue(c90000508.indct)
	c:RegisterEffect(e4)
	--protection thing
end
--protection
function c90000508.indtg(e,c)
	return c:IsSetCard(0x114) and c:IsType(TYPE_MONSTER)
end
function c90000508.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE)~=0 or bit.band(r,REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end
