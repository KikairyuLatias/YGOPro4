--Champion Flash Flyer - Sakura
function c90001248.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(Card.IsSetCard,0x4c9),1,99)
	c:EnableReviveLimit()
	--effect immunity
		--cannot target
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetValue(aux.tgoval)
		c:RegisterEffect(e1)
		--indes
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e2:SetRange(LOCATION_MZONE)
		e2:SetValue(c90001248.indval)
		c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90001248,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c90001248.target)
	e3:SetOperation(c90001248.activate)
	c:RegisterEffect(e3)
	--the power of ZPD banish authority, so lock on and shoot
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90001248,1))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90001248.target2)
	e4:SetOperation(c90001248.operation2)
	c:RegisterEffect(e4)
	--go to P-zone
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c90001248.pencon)
	e5:SetTarget(c90001248.pentg)
	e5:SetOperation(c90001248.penop)
	c:RegisterEffect(e5)
	--Flyer power up
		--atk up
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_FIELD)
		e6:SetCode(EFFECT_UPDATE_ATTACK)
		e6:SetRange(LOCATION_PZONE)
		e6:SetTargetRange(LOCATION_MZONE,0)
		e6:SetTarget(c90001248.tg)
		e6:SetValue(c90001248.val)
		c:RegisterEffect(e6)
		--def up
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_FIELD)
		e7:SetCode(EFFECT_UPDATE_DEFENSE)
		e7:SetRange(LOCATION_PZONE)
		e7:SetTargetRange(LOCATION_MZONE,0)
		e7:SetValue(c90001248.val)
		e7:SetTarget(c90001248.tg)
		c:RegisterEffect(e7)
	--Skill Drain
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetRange(LOCATION_PZONE)
	e8:SetTargetRange(0,LOCATION_MZONE)
	e8:SetTarget(c90001248.disable)
	e8:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e8)
end

--immunity
function c90001248.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--special summon
function c90001248.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x4c9) or c:IsCode(90001215) 
end
function c90001248.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001248.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c90001248.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001248.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

-- lock and fire
function c90001248.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,nil) end 
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c90001248.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,1,nil)
	e:GetHandler():RegisterFlagEffect(90001248,RESET_EVENT+0x1fe0000,0,1)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end

--protection value
function c90001248.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--pendulum scale
function c90001248.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c90001248.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c90001248.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end

--negate the opponent
function c90001248.disable(e,c)
	return c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end

--boost
function c90001248.tg(e,c)
	return c:IsSetCard(0x4c9) and c:IsType(TYPE_MONSTER)
end
function c90001248.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x4c9) or c:IsCode(90001215)
end
function c90001248.val(e,c)
	return Duel.GetMatchingGroupCount(c90001248.filter2,c:GetControler(),LOCATION_MZONE,0,nil)*300
end