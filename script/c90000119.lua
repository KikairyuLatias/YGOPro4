-- ＺＰＤ警察 − 「スナーロフ」
function c90000119.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,90000119)
	e1:SetCondition(c90000119.spcon)
	c:RegisterEffect(e1)
	--return to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000119,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c90000119.target)
	e2:SetCondition(c90000119.descon)
	e2:SetOperation(c90000119.operation)
	c:RegisterEffect(e2)
end

--ss
function c90000119.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b0) and not c:IsCode(90000119)
end
function c90000119.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000119.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

--bounce
function c90000119.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90000119.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c90000119.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b0) and c:GetCode()~=90000119
end
function c90000119.filter2(c)
	return c:IsAbleToDeck()
end
function c90000119.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c90000119.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000119.filter2,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c90000119.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c90000119.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end