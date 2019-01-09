--Pony Assault Soldier
function c90000650.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x439),2,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c90000650.splimit)
	c:RegisterEffect(e1)
	--cannot be targeted by card effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_DECK)
	e3:SetCondition(c90000650.descon)
	e3:SetTarget(c90000650.destg)
	e3:SetOperation(c90000650.desop)
	c:RegisterEffect(e3)	
	--draw for ponies
end
--no target
function c90000650.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end
--fusion restriction
function c90000650.splimit(e,se,sp,st)
return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION

end
--ToPendulum
function c90000650.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c90000650.desfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDestructable()
end
function c90000650.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c90000650.desfilter,tp,LOCATION_SZONE,0,1,c) end
	local sg=Duel.GetMatchingGroup(c90000650.desfilter,tp,LOCATION_SZONE,0,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c90000650.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c90000650.desfilter,tp,LOCATION_SZONE,0,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,8,POS_FACEUP,true)
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP)
	end
end
