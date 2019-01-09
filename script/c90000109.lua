-- ＺＰＤ警察 − 「ビャクロウ」
function c90000109.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90000109.datg)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c90000109.rdcon)
	e2:SetOperation(c90000109.rdop)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x4b0))
	c:RegisterEffect(e2)
end

--direct attack
function c90000109.filter(e,c)
	return c:IsSetCard(0x4b0)
end

function c90000109.datg(e,c)
	return c:IsSetCard(0x4b0)
end
function c90000109.rdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and c==Duel.GetAttacker() and Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c90000109.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end
