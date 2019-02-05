--Superstar Pony Kikoba
function c90000642.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c90000642.val)
	c:RegisterEffect(e2)
	--def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetValue(c90000642.val)
	c:RegisterEffect(e3)
	--lvup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000642,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c90000642.lvtg)
	e4:SetCountLimit(1,90000642)
	e4:SetOperation(c90000642.lvop)
	c:RegisterEffect(e4)
end
--pony power
function c90000642.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x439)
end
function c90000642.val(e,c)
	return Duel.GetMatchingGroupCount(c90000642.filter2,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*100
end
--level mod
function c90000642.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c90000642.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local opt=Duel.SelectOption(tp,aux.Stringid(90000642,0),aux.Stringid(90000642,1))
	e:SetLabel(opt)
end
function c90000642.lvop(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local g=Duel.GetMatchingGroup(c90000642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(opt/-1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c90000642.lvop2(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local g=Duel.GetMatchingGroup(c90000642.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end