--Diver Deer Major Rangikouru
function c90001139.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2,c90001139.ovfilter,aux.Stringid(90001139,0),2,c90001139.xyzop)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90001139,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetTarget(c90001139.target)
	e1:SetOperation(c90001139.activate)
	c:RegisterEffect(e1)
	--attach stuff to this as material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90001139,2))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetTarget(c90001139.mttg)
	e2:SetOperation(c90001139.mtop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c90001139.reptg)
	e3:SetValue(c90001139.repval)
	c:RegisterEffect(e3)
end
--alt summon condition (not like you can summon this normally anyway...)
function c90001139.ovfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and c:IsSetCard(0x4af) and c:IsAttackAbove(2000)
end

function c90001139.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,90001139)==0 end
	Duel.RegisterFlagEffect(tp,90001139,RESET_PHASE+PHASE_END,0,1)
	return true
end

--special summoning
function c90001139.filter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_BEASTWARRIOR)
end
function c90001139.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001139.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c90001139.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001139.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

--attach
function c90001139.mtfilter(c,e)
	return (c:IsLocation(LOCATION_HAND) or c:IsLocation(LOCATION_DECK)) and not c:IsType(TYPE_TOKEN) and c:IsSetCard(0x4af) and not c:IsImmuneToEffect(e)
end
function c90001139.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90001139.mtfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e) end
end
function c90001139.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c90001139.mtfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end

--replace
function c90001139.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_ONFIELD)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c90001139.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=c:GetLinkedGroup()
	if chk==0 then return eg:IsExists(c90001139.repfilter,1,nil,tp) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c90001139.repval(e,c)
	return c90001139.repfilter(c,e:GetHandlerPlayer())
end