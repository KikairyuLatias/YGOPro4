--Flyer Guidance
function c90001236.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Avoid MR4
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
