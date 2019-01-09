--Pony Summon Reaction
function c90000636.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCost(c90000636.cost)
	e1:SetCondition(c90000636.condition1)
	e1:SetTarget(c90000636.target)
	e1:SetOperation(c90000636.activate)
	c:RegisterEffect(e1)
	--Activate(Monster Effect)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCost(c90000636.cost)
	e2:SetCondition(c90000636.condition2)
	e2:SetTarget(c90000636.target2)
	e2:SetOperation(c90000636.activate2)
	c:RegisterEffect(e2)
end
function c90000636.cfilter(c)
	return (c:IsSetCard(0x439) or c:IsSetCard(0x1439)) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c90000636.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c90000636.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c90000636.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c90000636.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c90000636.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c90000636.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end

function c90000636.condition2(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph<=PHASE_DAMAGE_CAL and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c90000636.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90000636.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
