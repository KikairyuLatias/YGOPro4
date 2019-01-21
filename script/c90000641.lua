--Advanced Scuba Pony Akari
function c90000641.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.FilterBoolFunction(Card.IsCode,90000606),1,1)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c90000641.disable)
	e1:SetCondition(c90000641.discon)
	e1:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e1)
	--become a scale
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000641,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c90000641.pencon)
	e2:SetTarget(c90000641.pentg)
	e2:SetOperation(c90000641.penop)
	c:RegisterEffect(e2)
end

--to pendulumZ
function c90000641.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return r&REASON_EFFECT+REASON_BATTLE~=0 and c:IsFaceup()
end
function c90000641.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c90000641.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end

--neg stuff
function c90000641.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x439)
end
function c90000641.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c90000641.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c90000641.disable(e,c)
	return c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end