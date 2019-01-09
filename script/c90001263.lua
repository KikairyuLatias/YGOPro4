--Zoey the Snowstorm Reindeer Ninja
function c90001263.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90001263,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,90001263)
	e1:SetTarget(c90001263.sptg)
	e1:SetOperation(c90001263.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c90001263.reptg)
	e3:SetValue(c90001263.repval)
	e3:SetOperation(c90001263.repop)
	c:RegisterEffect(e3)
	--banish replace [fix later]
end

--summon rudolph and make his dreams come true!
function c90001263.filter(c,e,tp)
	return c:IsCode(90001251) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90001263.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001263.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c90001263.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001263.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

--protect my friends
function c90001263.filter2(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0x9d0) and not c:IsReason(REASON_REPLACE) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c90001263.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c90001263.filter2,1,nil,tp) and not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(90001263,1))
end
function c90001263.repval(e,c)
	return c90001263.filter2(c,e:GetHandlerPlayer())
end
function c90001263.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end