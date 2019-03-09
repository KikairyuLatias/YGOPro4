--Eclipse Dream Trainer
function c90000462.initial_effect(c)
	--Extra Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_EXTRA_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetOperation(c90000462.extracon)
	e1:SetValue(c90000462.extraval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,90000462)
	e2:SetCost(c90000462.indcost)
	e2:SetTarget(c90000462.indtg)
	e2:SetOperation(c90000462.indop)
	c:RegisterEffect(e2)
end
--extra material
function c90000462.extracon(c,e,tp,sg,mg,lc,og,chk)
	return (sg+mg):Filter(Card.IsLocation,nil,LOCATION_MZONE):IsExists(Card.IsSetCard,og,1,0x5f9) and
	#(sg&sg:Filter(c90000462.flagcheck,nil))<2
end
function c90000462.flagcheck(c)
	return c:GetFlagEffect(id)>0
end
function c90000462.extraval(chk,summon_type,e,...)
	local c=e:GetHandler()
	if chk==0 then
		local tp,sc=...
		if not summon_type==SUMMON_TYPE_LINK or not sc:IsSetCard(0x5f9) or Duel.GetFlagEffect(tp,id)>0 then
			return Group.CreateGroup()
		else
			local feff=c:RegisterFlagEffect(id,0,0,1)
			local eff=Effect.CreateEffect(c)
			eff:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			eff:SetCode(EVENT_ADJUST)
			eff:SetOperation(function(e)feff:Reset() e:Reset() end)
			Duel.RegisterEffect(eff,0)
			return Group.FromCards(c)
		end
	else
		local sg,sc,tp=...
		if summon_type&SUMMON_TYPE_LINK == SUMMON_TYPE_LINK and #sg>0 then
			Duel.Hint(HINT_CARD,tp,id)
			Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
		end
	end
end

--protection (and draw)
function c90000462.indcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c90000462.trigfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f9) and c:IsType(TYPE_LINK) and c:IsLinkAbove(3)
end
function c90000462.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f9)
end
function c90000462.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c90000462.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000462.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c90000462.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c90000462.indop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90000460.trigfilter,tp,LOCATION_MZONE,0,nil)
	local tc=Duel.GetFirstTarget()
	local g=Duel.SelectMatchingCard(tp,c90000460.filter,tp,LOCATION_MZONE,0,1,1,nil)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end
--add rest of the effect later for drawing