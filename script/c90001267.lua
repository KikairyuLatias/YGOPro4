--Snowstorm Reindeer Jutsu: Blizzard Dance
function c90001267.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c90001267.condition)
	e1:SetTarget(c90001267.target)
	e1:SetOperation(c90001267.activate)
	c:RegisterEffect(e1)
end
--s/t sniping
function c90001267.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0)
end
function c90001267.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90001267.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c90001267.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c90001267.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c90001267.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c90001267.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c90001267.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,2,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c90001267.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end