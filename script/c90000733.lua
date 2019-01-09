--Bunny Pet Girl
function c90000733.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91512835,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_MAIN1)
	e1:SetCountLimit(1)
	e1:SetTarget(c90000733.sptg)
	e1:SetOperation(c90000733.spop)
	c:RegisterEffect(e1)
end
--summon a token
function c90000733.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,90000799,0,0x4011,1200,1000,3,RACE_BEAST,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c90000733.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,90000799,0,0x4011,1200,1000,3,RACE_BEAST,ATTRIBUTE_LIGHT) then
		local token=Duel.CreateToken(tp,90000799)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end