--Psychic Dragon Princess Latias
function c90000251.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(Card.IsRace,RACE_DRAGON),1,99)
	c:EnableReviveLimit()
	--added typing
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_RACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(RACE_PSYCHIC)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000251,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,90000251)
	e2:SetCondition(c90000251.negcon)
	e2:SetCost(c90000251.negcost)
	e2:SetTarget(c90000251.negtg)
	e2:SetOperation(c90000251.negop)
	c:RegisterEffect(e2)
	--atk halving
end

--negation
function c90000251.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and Duel.IsChainNegatable(ev)
end
function c90000251.cfilter(c)
	return c:IsSetCard(0x5f1) and c:IsDiscardable()
end
function c90000251.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000251.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c90000251.cfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c90000251.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c90000251.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsRelateToEffect(re) then
		Duel.SendtoGrave(eg,REASON_EFFECT)
	end
end

