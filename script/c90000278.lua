--Psychic Hero Vapor Blaster
function c90000278.initial_effect(c)
	--damage translation (battle)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_REVERSE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e1:SetTarget(c90000278.efilter)
	e2:SetTargetRange(1,0)
	e2:SetValue(c90000278.rev2)
	c:RegisterEffect(e2)
	--draw effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000278,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c90000278.drcon)
	e3:SetTarget(c90000278.drtg)
	e3:SetOperation(c90000278.drop)
	c:RegisterEffect(e3)
	--retrieve effect
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000278,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c90000278.drcon)
	e4:SetTarget(c90000278.target)
	e4:SetOperation(c90000278.operation)
	c:RegisterEffect(e4)
end

--reverse damage
function c90000278.rev2(e,re,r,rp,rc)
	return bit.band(r,REASON_BATTLE)>0
end
function c90000278.efilter(e,c)
	return c:IsSetCard(0x5f2)
end

--functions when a [Psychic Hero] destroys something
function c90000278.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	while rc do
		if rc:IsStatus(STATUS_OPPO_BATTLE) then
			if rc:IsRelateToBattle() then
				if rc:IsControler(tp) and rc:IsSetCard(0x5f2) then return true end
			else
				if rc:GetPreviousControler()==tp and rc:IsPreviousSetCard(0x5f2) then return true end
			end
		end
		rc=eg:GetNext()
	end
	return false
end
--draw card
function c90000278.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000278.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
--retrieval
function c90000278.filter(c)
	return c:IsSetCard(0x5f2) and c:IsAbleToHand()
end
function c90000278.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000278.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c90000278.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000278.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end