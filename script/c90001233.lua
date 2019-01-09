--Flyer Victory Mountain - Lanakila
function c90001233.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--snow flyer
		--atk up
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetRange(LOCATION_FZONE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetTarget(c90001233.tg)
		e2:SetValue(c90001233.val)
		c:RegisterEffect(e2)
		--def up (snow flyer)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_UPDATE_DEFENSE)
		e3:SetRange(LOCATION_FZONE)
		e3:SetTargetRange(LOCATION_MZONE,0)
		e3:SetValue(c90001233.val)
		e3:SetTarget(c90001233.tg)
		c:RegisterEffect(e3)
	--special summoning
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90001233.target)
	e4:SetOperation(c90001233.activate)
	c:RegisterEffect(e4)
	--remove
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e5:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e5:SetRange(LOCATION_FZONE)
	e5:SetTargetRange(0,0xff)
	e5:SetValue(LOCATION_REMOVED)
	e5:SetTarget(c90001233.rmtg)
	c:RegisterEffect(e5)
end

--boost
function c90001233.tg(e,c)
	return c:IsSetCard(0x4c9) or c:IsCode(90001215) and c:IsType(TYPE_MONSTER)
end
function c90001233.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4c9)
end
function c90001233.val(e,c)
	return Duel.GetMatchingGroupCount(c90001233.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end

--ss condition
function c90001233.filter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x4c9) or c:IsCode(90001215)
end
function c90001233.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001233.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c90001233.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001233.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

-- banishing
function c90001233.rmtg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer()
end