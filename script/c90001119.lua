-- Diver Deer Underwater Training
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.tg)
	e2:SetValue(s.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetValue(cid.val2)
	c:RegisterEffect(e3)
	--special summoning
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,id)
	e4:SetTarget(s.target)
	e4:SetOperation(s.activate)
	c:RegisterEffect(e4)
	--recycle links?
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetDescription(aux.Stringid(id,2))
	e5:SetRange(LOCATION_FZONE)
	e5:SetCountLimit(1,id+99999)
	e5:SetTarget(s.target2)
	e5:SetOperation(s.activate2)
	c:RegisterEffect(e5)
end

--boost
function s.tg(e,c)
	return c:IsSetCard(0x4af) and c:IsType(TYPE_MONSTER)
end
function s.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af)
end
function s.val(e,c)
	return Duel.GetMatchingGroupCount(s.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function s.val2(e,c)
	return Duel.GetMatchingGroupCount(s.filter,c:GetControler(),0,LOCATION_MZONE,nil)*200
end

--ss condition
function s.filter2(c)
	return c:IsSetCard(0x4af) and c:IsType(TYPE_MONSTER) and c:GetLevel()<=4
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

-- recycle link thing
function s.spfilter(c,code,lv,e,tp)
	return c:GetLink()==link and c:IsSetCard(0x4af) and not c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function s.filter3(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x4af) and c:IsType(TYPE_LINK) and c:IsAbleToExtra()
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetCode(),c:GetLink(),e,tp)
		and Duel.GetLocationCountFromEx(tp,tp,c)>0
end
function s.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and s.filter3(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.filter3,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.filter3,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCountFromEx(tp,tp,tc)<=0 then return end
	if not tc:IsRelateToEffect(e) then return end
	local code=tc:GetCode()
	local lv=tc:GetLink()
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,code,lv,e,tp)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end