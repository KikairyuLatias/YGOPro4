--Blitzen the Snowstorm Reindeer Ninja
function c90001259.initial_effect(c)
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c90001259.dcon)
	e1:SetOperation(c90001259.dop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90001259.target)
	c:RegisterEffect(e2)
end

--double damage
function c90001259.dcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsSetCard(0x9d0) and tc:GetBattleTarget()~=nil
end
function c90001259.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end

--piercing
function c90001259.target(e,c)
	return c:IsSetCard(0x9d0)
end