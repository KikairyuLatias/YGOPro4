--Psychic Dragon Soldier Jikan
local s,id=GetID()
function s.initial_effect(c)
	--double attack if destroys monster attacking
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(s.atcon)
	e1:SetOperation(s.atop)
	c:RegisterEffect(e1)
	--opponent cannot attack with monster next turn
		--abyss script - heavenly evil spirit (something???)
end
function s.atcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsChainAttackable()
end
function s.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end