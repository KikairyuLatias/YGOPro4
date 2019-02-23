-- Snow Flyer - Blitzen
function c90001209.initial_effect(c)
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c90001209.dcon)
	e1:SetOperation(c90001209.dop)
	c:RegisterEffect(e1)
end

--functions
function c90001209.dcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsSetCard(0x14c9) and tc:GetBattleTarget()~=nil
end
function c90001209.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
