--Rider Deer Rikusho
function c90000852.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c90000852.val)
	c:RegisterEffect(e1)
	--def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c90000852.val)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_PIERCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c90000852.target)
	c:RegisterEffect(e3)
	--shuffle into deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000852,2))
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90000852.target2)
	e4:SetOperation(c90000852.operation2)
	c:RegisterEffect(e4)
end
--drop
function c90000852.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5a9)
end
function c90000852.val(e,c)
	return Duel.GetMatchingGroupCount(c90000852.filter,c:GetControler(),0,LOCATION_MZONE,nil)*-300
end

-- lock and fire
function c90000852.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil) end 
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c90000852.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,1,nil)
	e:GetHandler():RegisterFlagEffect(90000852,RESET_EVENT+0x1fe0000,0,1)
	Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
end
--piercer
function c90000852.target(e,c)
	return c:IsSetCard(0x5a9)
end

--weaken shit up
function c90000852.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x5a9)
end
function c90000852.val(e,c)
	return Duel.GetMatchingGroupCount(c90000852.filter2,c:GetControler(),0,LOCATION_MZONE,nil)*-300
end