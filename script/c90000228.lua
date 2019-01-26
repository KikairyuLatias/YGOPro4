--Psychic Dragon Star Tendo
function c90000228.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--protection
	--armades with conditions
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c90000228.aclimit)
	e2:SetCondition(c90000228.condition)
	c:RegisterEffect(e2)
end
--armades
function c90000228.indcon(e)
	return Duel.GetAttacker()==e:GetHandler() and Duel.IsExistingMatchingCard(c90000228.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c90000228.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
