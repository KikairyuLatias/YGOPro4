-- Skateboard Dragon Trick
function c90000309.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x11e8)
	e1:SetTarget(c90000309.target)
	e1:SetOperation(c90000309.activate)
	c:RegisterEffect(e1)
end
function c90000309.filter(c)
	return c:IsSetCard(0x5f0) or c:IsSetCard(0x15f0) and c:IsAbleToGrave()
end
function c90000309.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000309.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c90000309.posfilter(c)
	return c:IsFacedown() and c:IsSetCard(0x5f0)
end
function c90000309.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c90000309.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		local tg=Duel.GetMatchingGroup(c90000309.posfilter,tp,LOCATION_MZONE,0,nil)
		if tg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(90000309,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg=tg:Select(tp,1,5,nil)
			Duel.ChangePosition(sg,POS_FACEUP_DEFENSE)
		end
	end
end
