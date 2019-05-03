--Dreamlight Raccoon
function c90000439.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c90000439.matfilter,2,2)
	--retrieval
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000439,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c90000439.con)
	e1:SetTarget(c90000439.tg)
	e1:SetOperation(c90000439.op)
	c:RegisterEffect(e1)
	--added NS for dreamlight
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5f7))
	c:RegisterEffect(e2)
end
--materials
function c90000439.matfilter(c,scard,sumtype,tp)
	return c:IsSetCard(0x5f7,scard,sumtype,tp) or c:IsSetCard(0x5f8,scard,sumtype,tp)
end
--return
function c90000439.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c90000439.filter(c)
	return c:IsSetCard(0x5f7) or c:IsSetCard(0x5f8) and c:IsAbleToHand() and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c90000439.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x14) and chkc:IsControler(tp) and c90000439.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000439.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c90000439.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c90000439.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end