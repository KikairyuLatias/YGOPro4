-- Diver Deer Master Salvia
function c90001118.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x4af),3)
	c:EnableReviveLimit()
	--targeting immunity
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--shuffle stuff into deck (WIP)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90001118,0))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c90001118.destg)
	e2:SetOperation(c90001118.desop)
	c:RegisterEffect(e2,false,1)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c90001118.tgtg)
	e3:SetOperation(c90001118.tgop)
	c:RegisterEffect(e3)
	end
--because I can get into places you can't
function c90001118.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--shuffle into deck
function c90001118.desfilter(c)
	return c:IsAbleToDeck()
end
function c90001118.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetLinkedGroupCount()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c90001118.desfilter(chkc) end
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c90001118.desfilter,tp,0,LOCATION_HAND,1,nil) end
	local g=Duel.GetMatchingGroup(c90001118.desfilter,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	c:RegisterFlagEffect(0,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(90001118,0))
end
function c90001118.desop(e,tp,eg,ep,ev,re,r,rp)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c90001118.desfilter,tp,0,LOCATION_HAND,1,ct,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,ct)
		local ct2=Duel.SendtoDeck(g,REASON_EFFECT)
	end
end

--extra attack
function c90001118.tgfilter(c)
	return c:IsSetCard(0x4af) and c:IsAbleToRemove()
end
function c90001118.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90001118.tgfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c90001118.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c90001118.tgfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,2,nil)
	if g:GetCount()==0 then return end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local c=e:GetHandler()
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)
	if ct>0 and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end