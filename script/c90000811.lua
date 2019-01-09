-- Sunbeast 'Elepane
function c90000811.initial_effect(c)
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c90000811.dcon)
	e1:SetOperation(c90000811.dop)
	c:RegisterEffect(e1)
end

--functions
function c90000811.dcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget()==nil then return false end
	return eg:GetFirst():IsSetCard(0x640)
end
function c90000811.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
