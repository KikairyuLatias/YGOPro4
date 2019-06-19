--Superstar Professional Equestrian Rider Enríque FX
local s,id=GetID()
function s.initial_effect(c)
	--summon conditions
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_EFFECT),3,5,s.lcheck)
	--banish stuff
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(s.target2)
	e1:SetOperation(s.operation2)
	c:RegisterEffect(e1)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(s.indval)
	c:RegisterEffect(e3)
	--stat bonus
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(s.atkval)
	c:RegisterEffect(e4)
end
--summon condition
function s.lcheck(g,lc,tp)
	return g:IsExists(Card.IsRace,1,nil,RACE_BEAST)
end
--so advanced it is not funny
function s.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end
--banish forever
function s.target2(e,tp,eg,ep,ev,re,r,rp,chk)
   if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,g1:GetCount(),0,0)
end
function s.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,1,2,nil)
	e:GetHandler():RegisterFlagEffect(id,RESET_EVENT+0x1fe0000,0,1)
	Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
end

--stat value
function s.cfilter(c)
	return c:IsRace(RACE_BEAST)
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.cfilter,0,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,nil)*300
end