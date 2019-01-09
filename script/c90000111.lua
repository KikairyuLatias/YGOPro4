--ＺＰＤ検査手順
function c90000111.initial_effect(c)
	--getting searches will get you punished
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000111,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,90000111)
	e2:SetCondition(c90000111.hdcon)
	e2:SetTarget(c90000111.hdtg)
	e2:SetOperation(c90000111.hdop)
	c:RegisterEffect(e2)
end

--cut off hands
function c90000111.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c90000111.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and eg:IsExists(c90000111.cfilter,1,nil,1-tp) 
end
function c90000111.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
end
function c90000111.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
