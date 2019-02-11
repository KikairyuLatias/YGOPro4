--Superstar Pony Recruiter
function c90000654.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x439),4,2)
	c:EnableReviveLimit()
	--attach a pony as Xyz Material
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(90000654,0))
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCountLimit(1)
	e0:SetTarget(c90000654.mttg)
	e0:SetOperation(c90000654.mtop)
	c:RegisterEffect(e0)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000654,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c90000654.spcost)
	e1:SetTarget(c90000654.sptg)
	e1:SetOperation(c90000654.spop)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
end

--rank up
function c90000654.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,3,REASON_COST) and c:GetFlagEffect(id)==0 end
	c:RemoveOverlayCard(tp,3,3,REASON_COST)
	c:RegisterFlagEffect(id,RESET_CHAIN,0,1)
end
function c90000654.filter(c,e,tp,rk,pg)
	return c:IsRank(rk+1) or c:IsRank(rk+2) or c:IsRank(rk+3) or c:IsRank(rk+4) or c:IsRank(rk+5) or c:IsRank(rk+6) or c:IsRank(rk+7) or c:IsRank(rk+8) and c:IsSetCard(0x439) and e:GetHandler():IsCanBeXyzMaterial(c,tp)
		and (#pg<=0 or pg:IsContains(e:GetHandler())) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c90000654.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local pg=aux.GetMustBeMaterialGroup(tp,Group.FromCards(e:GetHandler()),tp,nil,nil,REASON_XYZ)
		return #pg<=1 and Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0
			and Duel.IsExistingMatchingCard(c90000654.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler():GetRank(),pg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c90000654.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp,tp,c)<=0 or c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	local pg=aux.GetMustBeMaterialGroup(tp,Group.FromCards(c),tp,nil,nil,REASON_XYZ)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000654.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c:GetRank(),pg)
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if #mg~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end

--attach
function c90000654.mtfilter(c,e)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and not c:IsType(TYPE_TOKEN) and c:IsSetCard(0x439) and not c:IsImmuneToEffect(e)
end
function c90000654.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000654.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,e) end
end
function c90000654.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c90000654.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
