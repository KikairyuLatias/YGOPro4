--Skystorm Mecha Base
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk boost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(s.tg)
	e2:SetValue(400)
	c:RegisterEffect(e2)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(s.thtg)
	e4:SetOperation(s.thop)
	c:RegisterEffect(e4)
	--opponent can't trigger
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(s.actcon)
	e5:SetOperation(s.actop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e6)
end
--Dreamlight/star power up
function s.tg(e,c)
	return c:IsSetCard(0x7c7) and c:IsType(TYPE_MONSTER)
end
--search out more supports
function s.filter1(c)
	return c:IsSetCard(0x7c7) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--forget about triggering
function s.actcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsControler(tp) and tc:IsSetCard(0x7c7)
end
function s.actop(e,tp,eg,ep,ev,re,r,rp)
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetTargetRange(0,1)
	e5:SetValue(s.aclimit)
	e5:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e5,tp)
end
function s.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end