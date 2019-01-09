--ZPD Detective - Oates
function c90000123.initial_effect(c)
	--set (needs fixing)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000123,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS+EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c90000123.settg)
	e1:SetOperation(c90000123.setop)
	c:RegisterEffect(e1)
	--recover (OK)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000123,0))
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c90000123.target)
	e2:SetOperation(c90000123.operation)
	c:RegisterEffect(e2)
end

--set stuff
function c90000123.setfilter(c)
	return c:IsSetCard(0x4b0) and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)) and c:IsSSetable()
end
function c90000123.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000123.setfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
end
function c90000123.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c90000123.setfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
	end
end

--gain LP
function c90000123.recfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b0)
end
function c90000123.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000123.recfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c90000123.recfilter,tp,LOCATION_MZONE,0,nil)
	local rec=g:GetClassCount(Card.GetCode)*500
end
function c90000123.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90000123.recfilter,tp,LOCATION_MZONE,0,nil)
	local rec=g:GetClassCount(Card.GetCode)*500
	Duel.Recover(tp,rec,REASON_EFFECT)
end
