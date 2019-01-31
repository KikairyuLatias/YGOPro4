--Majespecter Rescue
function c90000534.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,90000534+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c90000534.target)
	e1:SetOperation(c90000534.activate)
	c:RegisterEffect(e1)
end
function c90000534.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xaa) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c90000534.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000534.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c90000534.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000534.filter,tp,LOCATION_EXTRA,0,1,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end