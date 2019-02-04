--Skystorm Mecha Jet - Cream Gale
function c90001005.initial_effect(c)
	--added normal summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x7c7))
	c:RegisterEffect(e1)
	--cannot die by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c90001005.indcon)
	c:RegisterEffect(e2)
end
--protection
function c90001005.indfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_MACHINE) and c~=e:GetHandler()
end
function c90001005.indcon(e)
	return Duel.IsExistingMatchingCard(c90001005.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end

