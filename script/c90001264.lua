--Hayashi the Snowstorm Reindeer Ninja
function c90001264.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90001264,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,90001264)
	e1:SetTarget(c90001264.sptg)
	e1:SetOperation(c90001264.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--act limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c90001264.chainop)
	c:RegisterEffect(e3)
end

--summon my other reindeer form and then unlock my Mangekyo Sharingan to protect friends
function c90001264.filter(c,e,tp)
	return c:IsCode(90001260) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90001264.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001264.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c90001264.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001264.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

--don`t bother triggering
function c90001264.chainop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsSetCard(0x9d0) then
		Duel.SetChainLimit(c90001264.chainlm)
	end
end
function c90001264.chainlm(e,rp,tp)
	return tp==rp
end