--Superstar Pony Duelist Kailani GX
function c90000662.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c90000662.spcheck)
	--float and stuff
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c90000662.spcon)
	e2:SetTarget(c90000662.sptg)
	e2:SetOperation(c90000662.spop)
	c:RegisterEffect(e2)
	--extra summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e4:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_EXTRA_SET_COUNT)
	c:RegisterEffect(e5)
end

--req
function c90000662.spcheck(g,lc,tp)
	return g:GetClassCount(Card.GetRace,lc,SUMMON_TYPE_LINK,tp)==1
end

--float stuff
function c90000662.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end

function c90000662.spfilter(c,e,tp)
	return (c:IsLevelBelow(4) and c:IsRace(RACE_BEAST)) or (c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_EARTH)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c90000662.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000662.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c90000662.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000662.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end