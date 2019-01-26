-- Psychic Dragon Kasumi
function c90000207.initial_effect(c)
	--ind
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c90000207.indval)
	c:RegisterEffect(e1)
	--life gain
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000207,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c90000207.reccon)
	e1:SetTarget(c90000207.rectg)
	e1:SetOperation(c90000207.recop)
	c:RegisterEffect(e1)
end

--protection
function c90000207.indval(e,c)
	return c:IsLevelAbove(4)
end

--life restore (need to adjust for Level of monster it is used)
function c90000207.reccon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end

function c90000207.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c90000207.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
