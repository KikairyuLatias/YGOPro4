--Snowstorm Reindeer Hidden Snow Leaf Village
function c90001265.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--snowstorm reindeer
		--atk up
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetRange(LOCATION_FZONE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetTarget(c90001265.tg)
		e2:SetValue(c90001265.val)
		c:RegisterEffect(e2)
		--def up (snow flyer)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_UPDATE_DEFENSE)
		e3:SetRange(LOCATION_FZONE)
		e3:SetTargetRange(LOCATION_MZONE,0)
		e3:SetValue(c90001265.val)
		e3:SetTarget(c90001265.tg)
		c:RegisterEffect(e3)
	--trigger supports from hand
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x9d0))
	e4:SetTargetRange(LOCATION_HAND,0)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e5)
	--remove
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e6:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e6:SetRange(LOCATION_FZONE)
	e6:SetTargetRange(0,0xff)
	e6:SetValue(LOCATION_REMOVED)
	e6:SetCondition(c90001265.bancon)
	e6:SetTarget(c90001265.rmtg)
	c:RegisterEffect(e6)
end

--boost
function c90001265.tg(e,c)
	return c:IsSetCard(0x9d0) and c:IsType(TYPE_MONSTER)
end
function c90001265.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0)
end
function c90001265.val(e,c)
	return Duel.GetMatchingGroupCount(c90001265.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end

-- banishing
function c90001265.banfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0) and c:IsType(TYPE_MONSTER)
end
function c90001265.bancon(e)
	return Duel.IsExistingMatchingCard(c90001265.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c90001265.rmtg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer()
end