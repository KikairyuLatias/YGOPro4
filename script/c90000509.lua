-- Furryparadise, Crazy City Fur Hire
function c90000509.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000509.tg)
	e2:SetValue(c90000509.val)
	c:RegisterEffect(e2)
	local e2a=e2:Clone()
	e2a:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2a)
	local e3=e2:Clone()
	e3:SetValue(c90000509.val2)
	c:RegisterEffect(e3)
	local e3a=e3:Clone()
	e3a:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3a)
	--special summoning
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000509,4))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,90000509)
	e4:SetTarget(c90000509.target)
	e4:SetOperation(c90000509.activate)
	c:RegisterEffect(e4)
	--draw power
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(90000509,5))
	e5:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c90000509.target2)
	e5:SetOperation(c90000509.activate2)
	c:RegisterEffect(e2)
end

--boost
function c90000509.tg(e,c)
	return c:IsSetCard(0x114) and c:IsType(TYPE_MONSTER)
end
function c90000509.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x114)
end
function c90000509.val(e,c)
	return Duel.GetMatchingGroupCount(c90000509.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
function c90000509.val2(e,c)
	return Duel.GetMatchingGroupCount(c90000509.filter,c:GetControler(),0,LOCATION_MZONE,nil)*300
end

--ss condition
function c90000509.filter2(c)
	return c:IsSetCard(0x114) and c:IsType(TYPE_MONSTER)
end
function c90000509.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000509.filter2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c90000509.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000509.filter2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

--draw power
function c90000509.filter3(c)
	return c:IsSetCard(0x604e) and c:IsAbleToDeck()
end
function c90000509.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c90000509.filter3,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000509.activate2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.IsPlayerCanDraw(tp) then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>3 then ct=3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c90000509.filter3,tp,LOCATION_HAND,0,1,ct,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,nil,3,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,g:GetCount(),REASON_EFFECT)
	end
end
