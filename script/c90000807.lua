--Sunbeast `Īliohae
function c90000807.initial_effect(c)
	--negate for days
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c90000807.disable)
	e1:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e1)
	--atk up (field)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000807.tg)
	e2:SetValue(c90000807.val)
	c:RegisterEffect(e2)
	--atk up (graveyard)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c90000807.tg)
	e3:SetValue(c90000807.val)
	c:RegisterEffect(e3)
	--def up (field)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetValue(c90000807.val)
	e4:SetTarget(c90000807.tg)
	c:RegisterEffect(e4)
	--def up (graveyard)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetValue(c90000807.val2)
	e5:SetTarget(c90000807.tg2)
	c:RegisterEffect(e5)
	--special summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(90000807,0))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetTarget(c90000807.sptg2)
	e6:SetOperation(c90000807.spop2)
	c:RegisterEffect(e6)
end

--negate everything
function c90000807.disable(e,c)
	return c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end
function c90000807.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--boost from field
function c90000807.tg(e,c)
	return c:IsSetCard(0x640)
end
function c90000807.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x640)
end
function c90000807.val(e,c)
	return Duel.GetMatchingGroupCount(c90000807.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end

--graveyard booster
function c90000807.tg2(e,c)
	return c:IsSetCard(0x640)
end
function c90000807.filter2(c)
	return c:IsSetCard(0x640)
end
function c90000807.val2(e,c)
	return Duel.GetMatchingGroupCount(c90000807.filter2,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end

--revival
function c90000807.spfilter(c,e,tp)
	return c:IsSetCard(0x640) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()<=5
end
function c90000807.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000807.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c90000807.spop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000807.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
