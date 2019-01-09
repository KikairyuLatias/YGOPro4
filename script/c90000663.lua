--Superstar Pony Duelist Makani GX
function c90000663.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2)
	c:EnableReviveLimit()
	--float and stuff
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000663,1))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c90000663.sumcon)
	e1:SetTarget(c90000663.sumtg)
	e1:SetOperation(c90000663.sumop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e3)
end
--condition
function c90000663.lcheck(g,lc)
	return g:GetClassCount(Card.GetAttribute)==g:GetCount()
end

--float stuff
function c90000663.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c90000663.filter(c,e,tp)
	return c:IsLevelBelow(6) and (c:IsRace(RACE_BEAST) or c:IsAttribute(ATTRIBUTE_WIND)) and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function c90000663.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000663.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c90000663.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c90000663.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,nil,e,tp)
	if tg then
		Duel.SpecialSummon(tg,0,tp,tp,false,true,POS_FACEUP)
	end
end

