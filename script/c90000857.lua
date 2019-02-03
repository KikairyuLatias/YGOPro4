--Rider Deer Advance Promotion
function c90000857.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c90000857.target)
	e1:SetOperation(c90000857.operation)
	c:RegisterEffect(e1)
end
function c90000857.cfilter(c,e,tp,ft)
	local lv=c:GetLevel()
	return c:IsFaceup() and lv>0 and c:IsSetCard(0x5a9)
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5))
		and Duel.IsExistingMatchingCard(c90000857.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,lv+3,e,tp)
end
function c90000857.filter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsSetCard(0x5a9) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90000857.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroupCost(tp,c90000857.cfilter,1,false,nil,nil,e,tp,ft) end
	local rg=Duel.SelectReleaseGroupCost(tp,c90000857.cfilter,1,1,false,nil,nil,e,tp,ft)
	e:SetLabel(rg:GetFirst():GetLevel()+3)
	Duel.Release(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c90000857.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000857.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e:GetLabel(),e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		c:SetCardTarget(tc)
		Duel.SpecialSummonComplete()
	end
end