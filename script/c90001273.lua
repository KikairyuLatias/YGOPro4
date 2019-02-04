--Snowstorm Reindeer Jutsu: Tempest Blast Dragon
function c90001273.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c90001273.condition)
	e1:SetTarget(c90001273.target)
	e1:SetOperation(c90001273.activate)
	c:RegisterEffect(e1)
end
--monster bouncing
function c90001273.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0)
end
function c90001273.lmfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0) and c:IsLevelAbove(6)
end
function c90001273.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90001273.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c90001273.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c90001273.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c90001273.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c90001273.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c90001273.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,2,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	if Duel.IsExistingMatchingCard(c90001273.lmfilter,tp,LOCATION_MZONE,0,1,nil) and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			Duel.SetChainLimit(c90001273.chainlm)
		end
end
function c90001273.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
function c90001273.chainlm(e,rp,tp)
	return tp==rp
end