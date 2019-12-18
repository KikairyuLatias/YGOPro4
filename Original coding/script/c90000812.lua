-- Sunbeast 'Alopeke
function c90000812.initial_effect(c)
	--negation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000812,1))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c90000812.discon)
	e1:SetTarget(c90000812.distg)
	e1:SetOperation(c90000812.disop)
	c:RegisterEffect(e1)
end

--negate
function c90001255.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) 
	and Duel.IsExistingMatchingCard(c90001255.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end

function c90001255.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x640) and c~=e:GetHandler()
end
function c90000812.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90000812.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
