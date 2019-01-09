--Hikari the Genius Bunny
function c90000701.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c90000701.val)
	c:RegisterEffect(e2)
	--protect
	local e3=Effect.CreateEffect(c)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetTargetRange(LOCATION_MZONE)
	e3:SetTarget(c90000701.target)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c90000701.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x7D0)
end
function c90000701.val(e,c)
	return Duel.GetMatchingGroupCount(c90000701.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c90000701.target(e,c)
	return c~=e:GetHandler() and c:IsSetCard(0x7D0)
end
