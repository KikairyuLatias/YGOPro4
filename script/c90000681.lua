--Hazmanimal Yellow Fire Wolf
function c90000681.initial_effect(c)
	--atk up
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetRange(LOCATION_MZONE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetTarget(c90000681.tg)
		e2:SetValue(c90000681.val)
		c:RegisterEffect(e2)
	--token (need to add summon lock later)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000681,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90000681.sptg)
	e4:SetCost(c90000681.spcost)
	e4:SetOperation(c90000681.spop)
	c:RegisterEffect(e4)
end
--boost
function c90000681.tg(e,c)
	return c:IsSetCard(0x43a) and c:IsType(TYPE_MONSTER)
end
function c90000681.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x43a)
end
function c90000681.val(e,c)
	return Duel.GetMatchingGroupCount(c90000681.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end

--i make tokens
function c90000681.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,0) end
	Duel.PayLPCost(tp,0)
end

function c90000681.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,90000682,0x43a,0x4011,0,0,3,RACE_BEAST,ATTRIBUTE_FIRE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end

function c90000681.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,0x4011,0,0,3,RACE_BEAST,ATTRIBUTE_FIRE) then
		local token1=Duel.CreateToken(tp,90000682)
		Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
		local token2=Duel.CreateToken(tp,90000682)
		Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
		Duel.SpecialSummonComplete()
	end
end