-- Diver Deer Hishikusa
function c90001104.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90001104,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c90001104.con)
	e1:SetTarget(c90001104.tg)
	e1:SetOperation(c90001104.op)
	c:RegisterEffect(e1)
	--cannot be effect target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90001104.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end

--return
function c90001104.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c90001104.filter(c)
	return c:IsSetCard(0x4af) and c:IsAbleToHand() and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c90001104.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x14) and chkc:IsControler(tp) and c90001104.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90001104.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c90001104.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c90001104.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

--attack target
function c90001104.damfilter(c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsSetCard(0x4af)
end
function c90001104.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90001104.damfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c90001104.damfilter,tp,LOCATION_MZONE,0,nil)
	local dam=g:GetClassCount(Card.GetCode)*500
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c90001104.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90001104.damfilter,tp,LOCATION_MZONE,0,nil)
	local dam=g:GetClassCount(Card.GetCode)*500
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
function c90001104.tgtg(e,c)
	return c~=e:GetHandler() and c:IsSetCard(0x114)
end
