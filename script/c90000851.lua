--Rider Deer Gensui
function c90000851.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--stats up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_FZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90000851.tg)
	e1:SetValue(c90000851.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetValue(c90000851.val2)
	c:RegisterEffect(e2)
	--promotion
	--protect
	--banish
end

--boost
function c90000851.tg(e,c)
	return c:IsSetCard(0x5a9) and c:IsType(TYPE_MONSTER)
end
function c90000851.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5a9)
end
function c90000851.val(e,c)
	return Duel.GetMatchingGroupCount(c90000851.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c90000851.val2(e,c)
	return Duel.GetMatchingGroupCount(c90000851.filter,c:GetControler(),0,LOCATION_MZONE,nil)*200
end
