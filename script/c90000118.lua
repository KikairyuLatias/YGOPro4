--ＺＰＤ襲撃
function c90000118.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c90000118.condition)
	e1:SetTarget(c90000118.target)
	e1:SetOperation(c90000118.activate)
	c:RegisterEffect(e1)
end
function c90000118.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b0)
end
function c90000118.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90000118.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
--screw your hands
function c90000118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local gc=g:GetCount()
	if chk==0 then return gc>0 and g:FilterCount(Card.IsAbleToRemove,nil)==gc and Duel.IsPlayerCanDraw(1-tp,gc) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,gc,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,0)
end
function c90000118.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local gc=g:GetCount()
	if gc>0 and g:FilterCount(Card.IsAbleToRemove,nil)==gc then
		local oc=Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
		if oc<0 then
			Duel.Draw(1-tp,oc,REASON_EFFECT)
		end
	end
end