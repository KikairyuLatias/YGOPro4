--Scuba Pony Shira GX
function c90000672.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c90000672.lcheck)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000672,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1)
	e1:SetCondition(c90000672.hspcon)
	e1:SetTarget(c90000672.hsptg)
	e1:SetOperation(c90000672.hspop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000672,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c90000672.discon)
	e2:SetCost(c90000672.discost)
	e2:SetTarget(c90000672.distg)
	e2:SetOperation(c90000672.disop)
	c:RegisterEffect(e2)
end

--mat check
function c90000672.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end

--summon
function c90000672.hspcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c90000672.hspfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c90000672.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=Duel.GetZoneWithLinkedCount(1,tp)&0x1f
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_HAND+LOCATION_DECK) and c90000672.filter(chkc,e,tp,zone) end
	if chk==0 then return Duel.IsExistingTarget(c90000672.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c90000672.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c90000672.hspop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local zone=Duel.GetZoneWithLinkedCount(1,tp)&0x1f
	if tc and tc:IsRelateToEffect(e) and zone~=0  then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end

--negate
function c90000672.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c90000672.cfilter(c,g)
	return g:IsContains(c) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c90000672.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.CheckReleaseGroup(tp,c90000672.cfilter,1,nil,lg) end
	local g=Duel.SelectReleaseGroup(tp,c90000672.cfilter,1,1,nil,lg)
	Duel.Release(g,REASON_COST)
end
function c90000672.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90000672.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end