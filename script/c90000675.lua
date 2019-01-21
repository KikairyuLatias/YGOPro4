--Hazmanimal Pink Flare Deer
function c90000675.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,3,c90000675.lcheck)
	c:EnableReviveLimit()
	--moving
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000675,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c90000675.seqtg)
	e1:SetOperation(c90000675.seqop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000675,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c90000675.thtg)
	e2:SetOperation(c90000675.thop)
	c:RegisterEffect(e2)
	--shuffle 1 card on field to deck
end

--check if you are using a hazmanimal monster
function c90000675.lcheck(g,lc)
	return g:IsExists(c90000675.mzfilter,1,nil)
end
function c90000675.mzfilter(c)
	return c:IsSetCard(0x43a)
end

--moving
function c90000675.seqfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af)
end
function c90000675.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c90000675.seqfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000675.seqfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(90000675,1))
	Duel.SelectTarget(tp,c90000675.seqfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c90000675.seqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or not (Duel.GetLocationCount(tp,LOCATION_MZONE)>0)then return end
	local seq=tc:GetSequence()
	Duel.Hint(HINT_SELECTMSG,tp,571)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end

--search
function c90000675.filter1(c)
	return c:IsSetCard(0x43a) and c:IsAbleToHand()
end
function c90000675.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000675.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c90000675.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000675.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

--bounce (add later)