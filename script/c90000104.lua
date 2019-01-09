-- ＺＰＤ警察 − 「マックホルン」
function c90000104.initial_effect(c)
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c90000104.dcon)
	e1:SetOperation(c90000104.dop)
	c:RegisterEffect(e1)
end

--functions
function c90000104.dcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget()==nil then return false end
	return eg:GetFirst():IsSetCard(0x4b0)
end
function c90000104.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
