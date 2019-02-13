-- Flash Flyer - Hayashi Accel
function c90001239.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c90001239.matfilter,2,2)
	--don't bother chaining
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c90001239.chainop)
	c:RegisterEffect(e1)
	--ninja art: flyer hand sniping jutsu!
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90001239,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c90001239.hdcon)
	e2:SetTarget(c90001239.hdtg)
	e2:SetOperation(c90001239.hdop)
	c:RegisterEffect(e2)
end

--mat filter
function c90001239.matfilter(c,scard,sumtype,tp)
	return c:IsSetCard(0x4c9,scard,sumtype,tp) or c:IsSetCard(0x14c9,scard,sumtype,tp) or c:IsSetCard(0x24c9,scard,sumtype,tp) and c:IsAttribute(ATTRIBUTE_LIGHT,scard,sumtype,tp)
end

--don't even bother chaining
function c90001239.chainop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsSetCard(0x4c9) then
		Duel.SetChainLimit(c90001239.chainlm)
	end
end
function c90001239.chainlm(e,rp,tp)
	return tp==rp
end

--cut off hands
function c90001239.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) or c:IsPreviousLocation(LOCATION_GRAVE)
end
function c90001239.damfilter(c)
	return c:IsSetCard(0x4c9)
end
function c90001239.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and eg:IsExists(c90001239.cfilter,1,nil,1-tp)
end
function c90001239.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*200)
end
function c90001239.hdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:Select(tp,1)
		if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		Duel.BreakEffect()
		local gc=Duel.GetMatchingGroupCount(c90001239.damfilter,tp,LOCATION_MZONE,0,nil)
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		Duel.Damage(p,gc*200,REASON_EFFECT)
		end
	end
end
end