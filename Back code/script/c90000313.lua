--Skateboard Dragon Champion Hiensou
function c90000313.initial_effect(c)
	c:EnableReviveLimit()
	--discard/pop
	--blast the hell out of stuff
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000313,1))
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,90000313+100)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c90000313.discon)
	e2:SetTarget(c90000313.distg)
	e2:SetOperation(c90000313.disop)
	c:RegisterEffect(e2)
end

--negate
function c90000313.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c90000313.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90000313.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
