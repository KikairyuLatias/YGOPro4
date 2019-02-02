--Diver Deer Elite Sakura
function c290001110.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.NOT(aux.FilterBoolFunctionEx(Card.IsType,TYPE_TOKEN)),2)
	c:EnableReviveLimit()
	--banish until end phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(290001110,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,90001110)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c290001110.thtg)
	e1:SetOperation(c290001110.thop)
	c:RegisterEffect(e1)
	--summon friends and make opponent smaller (need to add in stat drop later)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(290001110,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,290001199)
	e2:SetTarget(c290001110.target)
	e2:SetOperation(c290001110.activate)
	c:RegisterEffect(e2)
end

-- spsummon
function c290001110.filter(c)
	return c:IsSetCard(0x4af) and c:IsType(TYPE_MONSTER)
end

function c290001110.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c290001110.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end

function c290001110.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c290001110.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)		
	end
end
--banish until end phase
function c290001110.thfilter(c)
	return c:IsType(TYPE_MONSTER) or c:IsType(SPELL) or c:IsType(TYPE_TRAP) and c:IsAbleToRemove()
end
function c290001110.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local ct=c:GetLinkedGroupCount()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c290001110.thfilter(chkc) end
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c290001110.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c290001110.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	c:RegisterFlagEffect(0,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(290001110,1))
end
function c290001110.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local fid=c:GetFieldID()
		local og=Duel.GetOperatedGroup()
		for oc in aux.Next(og) do
			oc:RegisterFlagEffect(290001110,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(og)
		e1:SetCondition(c290001110.retcon)
		e1:SetOperation(c290001110.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c290001110.retfilter(c,fid)
	return c:GetFlagEffectLabel(290001110)==fid
end
function c290001110.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:IsExists(c290001110.retfilter,1,nil,e:GetLabel()) then
		return true
	else 
		g:DeleteGroup()
		e:Reset()
		return false
	end
end
function c290001110.retop(e,tp,eg,ep,ev,re,r,rp)
	local og=e:GetLabelObject()
	local g=og:Filter(c290001110.retfilter,nil,e:GetLabel())
	og:DeleteGroup()
	if g:GetCount()<=0 then return end
	local p=g:GetFirst():GetPreviousControler()
	local tg=Group.CreateGroup()
	local ft=Duel.GetLocationCount(p,LOCATION_MZONE)
	if g:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOFIELD)
		tg:Merge(g:Select(p,ft,ft,nil))
	else
		tg:Merge(g)
	end
	for tc in aux.Next(tg) do
		Duel.ReturnToField(tc)
	end
end