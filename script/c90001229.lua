-- 千本桜馴鹿
function c90001229.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c90001229.condition)
	e1:SetTarget(c90001229.target)
	e1:SetOperation(c90001229.activate)
	c:RegisterEffect(e1)
end
function c90001229.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4c9) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_BEAST)
end
function c90001229.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90001229.cfilter,tp,LOCATION_MZONE,0,3,nil)
end
function c90001229.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c90001229.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90001229.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c90001229.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c90001229.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c90001229.filter,tp,0,LOCATION_ONFIELD,e:GetHandler())
	if sg:GetCount()>0 then
	Duel.Destroy(sg,REASON_EFFECT)
		Duel.BreakEffect()
		local tg=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
		local tc=tg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(500)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			e2:SetValue(500)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			tc=tg:GetNext()
		end
	end
end