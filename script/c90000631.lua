--Advanced Superstar Pony Duelist Makani
function c90000631.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.FilterBoolFunction(Card.IsCode,90000603),1,1)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(1,0)
	e1:SetCondition(c90000631.splimcon)
	e1:SetTarget(c90000631.splimit)
	c:RegisterEffect(e1)
	--spell indestruction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000631.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_DECK)
	e3:SetCondition(c90000631.descon)
	e3:SetTarget(c90000631.destg)
	e3:SetOperation(c90000631.desop)
	c:RegisterEffect(e3)
end
function c90000631.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c90000631.splimit(e,c)
	return not c:IsSetCard(0x439)
end
function c90000631.indtg(e,c)
	return c:IsSetCard(0x439) and c~=e:GetHandler()
end
--ToPendulum
function c90000631.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c90000631.desfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDestructable()
end
function c90000631.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c90000631.desfilter,tp,LOCATION_SZONE,0,1,c) end
	local sg=Duel.GetMatchingGroup(c90000631.desfilter,tp,LOCATION_SZONE,0,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c90000631.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c90000631.desfilter,tp,LOCATION_SZONE,0,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,7,POS_FACEUP,true)
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP)
	end
end
