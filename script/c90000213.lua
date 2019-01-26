--Psychic Dragon Soldier Jikan
function c90000213.initial_effect(c)
	--double attack if destroys monster attacking
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000213,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c90000213.atcon)
	e1:SetOperation(c90000213.atop)
	c:RegisterEffect(e1)
	--opponent cannot attack with monster next turn
		--abyss script - heavenly evil spirit (something???)
end
function c90000213.atcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsChainAttackable()
end
function c90000213.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end