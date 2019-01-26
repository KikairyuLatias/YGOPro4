--Psychic Dragon Chitatsu
function c90000223.initial_effect(c)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000223,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c90000223.drcon)
	e3:SetCountLimit(1,90000223)
	e3:SetTarget(c90000223.drtg)
	e3:SetOperation(c90000223.drop)
	e3:SetCountLimit(1,90000223)
	c:RegisterEffect(e3)
end
--draw when you summon with me (add restriction)
function c90000223.drcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO and c:GetReasonCard():IsSetCard(0x5f1)
end
function c90000223.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000223.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end