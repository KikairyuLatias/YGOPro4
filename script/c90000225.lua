--Psychic Dragon Higana
function c90000225.initial_effect(c)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,90000225)
	e2:SetCondition(c90000225.condition)
	e2:SetTarget(c90000225.target)
	e2:SetOperation(c90000225.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end

--condition
function c90000225.indfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1) and not c:IsCode(90000225)
end
function c90000225.condition(e)
	return Duel.IsExistingMatchingCard(c90000225.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end

--search
function c90000225.filter(c)
	return c:IsSetCard(0x5f1) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c90000225.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000225.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c90000225.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000225.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end