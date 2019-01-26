--Psychic Dragon Soldier Shoku
function c90000215.initial_effect(c)
	--mill thing
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000215,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetCondition(c90000215.atkcon)
	e1:SetTarget(c90000215.atktg)
	e1:SetOperation(c90000215.atkop)
	c:RegisterEffect(e1)
	--make zero
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000215,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c90000215.atktg2)
	e2:SetOperation(c90000215.atkop2)
	c:RegisterEffect(e2)
end
--deck mill
function c90000215.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler() and c90000215.atkcon(e,tp,eg,ep,ev,re,r,rp) and ep~=tp
end
function c90000215.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,1)
end
function c90000215.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
end
--zero (make it reset after standby)
function c90000215.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000215.filter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler()) end
end
function c90000215.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90000215.filter,tp,0,LOCATION_MZONE,nil,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end