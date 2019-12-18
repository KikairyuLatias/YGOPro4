--Flyer Guidance
function c90001236.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Avoid MR4
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetTarget(c90001236.reptg)
	e1:SetValue(c90001236.repval)
	c:RegisterEffect(e1)
	--Draw when you summon reindeer
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90001236,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,90001236)
	e3:SetCondition(c90001236.drcon)
	e3:SetTarget(c90001236.drtg)
	e3:SetOperation(c90001236.drop)
	c:RegisterEffect(e3)
end
--draw power
function c90001236.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4c9)
end
function c90001236.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and not eg:IsContains(e:GetHandler()) and eg:IsExists(c90001236.filter,1,nil)
end
function c90001236.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90001236.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

--return
function c90001236.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) or c:IsLocation(LOCATION_EXTRA) and c:IsSetCard(0x4c9) and c:IsType(TYPE_PENDULUM)
		and c:IsAbleToHand()
end
function c90001236.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return bit.band(r,REASON_EFFECT)~=0 and re and re:IsActiveType(TYPE_MONSTER)
		and eg:IsExists(c90001236.repfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(90001236,0)) then
		local g=eg:Filter(c90001236.repfilter,nil,tp)
		local ct=g:GetCount()
		if ct>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			g=g:Select(tp,1,ct,nil)
		end
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(LOCATION_HAND)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(90001236,RESET_EVENT+0x1de0000+RESET_PHASE+PHASE_END,0,1)
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e1:SetCode(EVENT_TO_HAND)
		e1:SetCountLimit(1)
		e1:SetCondition(c90001236.thcon)
		e1:SetOperation(c90001236.thop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		return true
	else return false end
end
function c90001236.repval(e,c)
	return false
end
function c90001236.thfilter(c)
	return c:GetFlagEffect(90001236)~=0
end
function c90001236.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c90001236.thfilter,1,nil)
end
function c90001236.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c90001236.thfilter,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end