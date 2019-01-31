--Majespecter Phoenix - Suzaku
function c90000533.initial_effect(c)
	--summon conditions
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WIND),2,3,c90000533.lcheck)
	--protection
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c90000533.unaffecttg)
	e1:SetValue(c90000533.unaffectval)
	c:RegisterEffect(e1)
	--cannot be tributed
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UNRELEASABLE_SUM)
	e2:SetTarget(c90000533.unaffecttg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--tribute to negate effects
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c90000533.condition)
	e3:SetCost(c90000533.cost)
	e3:SetTarget(c90000533.target)
	e3:SetOperation(c90000533.activate)
	c:RegisterEffect(e3)
end
--summon condition
function c90000533.lcheck(g,lc,tp)
	return g:IsExists(Card.IsSetCard,1,nil,0xd0)
end
--protection
function c90000533.unaffecttg(e,c)
	return (e:GetHandler():GetLinkedGroup():IsContains(c) or c==e:GetHandler()) and c:IsSetCard(0xd0) and c:IsFaceup()
end
function c90000533.unaffectedval(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
--delete thisv(effect neg)
function c90000533.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c90000533.cfilter(c)
	return (c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_SPELLCASTER)) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c90000533.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c90000533.cfilter,1,false,nil,nil) end
	local g=Duel.SelectReleaseGroupCost(tp,c90000533.cfilter,1,1,false,nil,nil)
	Duel.Release(g,REASON_COST)
end
function c90000533.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c90000533.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEDOWN,REASON_EFFECT)
	end
		Duel.BreakEffect()
		Duel.Damage(1-tp,800,REASON_EFFECT)
end