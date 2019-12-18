--閃光馴鹿ミッツィ
function c90001227.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--nullify damage for other reindeer (and Slyly / Leonard)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90001227.efilter)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--protect reindeer from Raigeki
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c90001227.indtg)
	e2:SetValue(c90001227.indval)
	c:RegisterEffect(e2)
	--atk def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c90001227.adcon)
	e3:SetTarget(c90001227.adtg)
	e3:SetValue(-500)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end

--zero damage
function c90001227.efilter(e,c)
	return c:IsSetCard(0x4c9)
end

--don't even bother to Raigeki me
function c90001227.indtg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x4c9) and c:IsRace(RACE_BEAST)
end
function c90001227.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end

--stat drop
function c90001227.adcon(e)
	local d=Duel.GetAttackTarget()
	if not d then return false end
	local tp=e:GetHandlerPlayer()
	if d:IsControler(1-tp) then d=Duel.GetAttacker() end
	return (d:IsSetCard(0x4c9))
end
function c90001227.adtg(e,c)
	return c==Duel.GetAttacker() or c==Duel.GetAttackTarget()
end