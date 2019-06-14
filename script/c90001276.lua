--Snowstorm Reindeer Jutsu: Creation Rebirth
function c90001276.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c90001276.condition)
	e1:SetTarget(c90001276.target)
	e1:SetOperation(c90001276.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c90001276.target2)
	e2:SetOperation(c90001276.operation)
	c:RegisterEffect(e2)
	--damage conversion
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_REVERSE_DAMAGE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(c90001276.rev)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetValue(c900001276.rev2)
	c:RegisterEffect(e4)
end

--lp boost
function c90001276.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0)
end
function c90001276.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90001276.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c90001276.recfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9d0)
end
function c90001276.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c90001276.recfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct*500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*500)
end
function c90001276.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c90001276.recfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Recover(tp,ct*500,REASON_EFFECT)
end

--reversing damage
function c90001276.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end

function c90001276.rev2(e,re,r,rp,rc)
	return bit.band(r,REASON_BATTLE)~=0
end

--retrieval from gy to hand
function c90001276.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c90001276.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end