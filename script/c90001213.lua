--Flyer Medal of Valor
function c90001213.initial_effect(c)
	--searching
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Change to Snow Flyer
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90001213.sertg)
	e1:SetValue(0x14c9)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTargetRange(LOCATION_HAND,0)
	c:RegisterEffect(e2)
end

--the initiation
function c90001213.sertg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x24c9)
end
