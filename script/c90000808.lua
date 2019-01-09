
--Sunbeast Unleash
function c90000808.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000808,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c90000808.ntcon)
	e2:SetTarget(c90000808.nttg)
	c:RegisterEffect(e2)
	--negation
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000808,1))
	e3:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c90000808.discon)
	e3:SetTarget(c90000808.distg)
	e3:SetCost(c90000808.discost)
	e3:SetOperation(c90000808.disop)
	c:RegisterEffect(e3)
end

--Catalyst Field
function c90000808.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c90000808.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x640)
end

--negation
function c90000808.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c90000808.disfilter(c)
	return c:IsSetCard(0x640) and c:IsDiscardable()
end
function c90000808.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000808.disfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c90000808.disfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c90000808.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90000808.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
