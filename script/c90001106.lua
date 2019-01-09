-- Diver Deer Kamila
function c90001106.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c90001106.spcon)
	e1:SetCountLimit(1,90001106)
	c:RegisterEffect(e1)
	--cannot die by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c90001106.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end

--ss
function c90001106.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af) and not c:IsCode(90001106)
end
function c90001106.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001106.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

--protection
function c90001106.indfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af) and not c:IsCode(90001106)
end
function c90001106.indcon(e)
	return Duel.IsExistingMatchingCard(c90001106.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
