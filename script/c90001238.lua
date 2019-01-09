-- Flash Flyer - Zoey Accel
function c90001238.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c90001238.matfilter,2,2)
	c:EnableReviveLimit()
	--protection (modify only for Flyers)
		--while I have Xyz, my friends are safe
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(0,LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		e1:SetValue(c90001238.atlimit)
		c:RegisterEffect(e1)	
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetTarget(c90001238.tglimit)
		e2:SetValue(aux.tgoval)
		c:RegisterEffect(e2)
	--kirin
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,90001238)
	e3:SetTarget(c90001238.thtg)
	e3:SetOperation(c90001238.thop)
	c:RegisterEffect(e3)
end

--material
function c90001238.matfilter(c,scard,sumtype,tp)
	return c:IsSetCard(0x4c9,scard,sumtype,tp) or c:IsSetCard(0x14c9,scard,sumtype,tp) or c:IsSetCard(0x24c9,scard,sumtype,tp) end

--protection from attack
function c90001238.atlimit(e,c)
	return c~=e:GetHandler()
end
function c90001238.tglimit(e,c)
	return c~=e:GetHandler()
end

--kirin stuff
function c90001238.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4c9) and c:IsAbleToHand()
end
function c90001238.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c90001238.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectTarget(tp,c90001238.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
end
function c90001238.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
