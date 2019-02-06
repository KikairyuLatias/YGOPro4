--Moon Bunny
function c90000748.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c90000748.lcheck)
	c:EnableReviveLimit()
	--unaffected
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90000748.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--banish until end phase
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000748,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c90000748.thtg)
	e2:SetOperation(c90000748.thop)
	c:RegisterEffect(e2)
end

--condition
function c90000748.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end

--protection
function c90000748.indtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end

--banish until end phase
function c90000748.thfilter(c)
	return c:IsType(TYPE_MONSTER) or c:IsType(SPELL) or c:IsType(TYPE_TRAP) and c:IsAbleToRemove()
end
function c90000748.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local ct=c:GetLinkedGroupCount()+1
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c90000748.thfilter(chkc) end
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c90000748.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c90000748.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	c:RegisterFlagEffect(0,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(90000748,1))
end
function c90000748.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local fid=c:GetFieldID()
		local og=Duel.GetOperatedGroup()
		for oc in aux.Next(og) do
			oc:RegisterFlagEffect(90000748,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(og)
		e1:SetCondition(c90000748.retcon)
		e1:SetOperation(c90000748.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c90000748.retfilter(c,fid)
	return c:GetFlagEffectLabel(90000748)==fid
end
function c90000748.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:IsExists(c90000748.retfilter,1,nil,e:GetLabel()) then
		return true
	else 
		g:DeleteGroup()
		e:Reset()
		return false
	end
end
function c90000748.retop(e,tp,eg,ep,ev,re,r,rp)
	local og=e:GetLabelObject()
	local g=og:Filter(c90000748.retfilter,nil,e:GetLabel())
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