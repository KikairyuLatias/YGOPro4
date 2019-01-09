--Diver Deer Naval Explosive
function c90001128.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c90001128.target)
	e1:SetCountLimit(1,90001128+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c90001128.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c90001128.handcon)
	c:RegisterEffect(e2)
end
--stuff
function c90001128.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c90001128.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af)
end
function c90001128.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c90001128.cfilter,tp,LOCATION_ONFIELD,0,c)
		e:SetLabel(ct)
		return Duel.IsExistingMatchingCard(c90001128.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,c)
	end
	local ct=e:GetLabel()
	local sg=Duel.GetMatchingGroup(c90001128.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,ct,0,0)
end
function c90001128.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(c90001128.cfilter,tp,LOCATION_ONFIELD,0,c)
	local g=Duel.GetMatchingGroup(c90001128.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	if g:GetCount()>=ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,ct,ct,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end

--handtrap cond
function c90001128.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x4af) and c:IsLinkAbove(2)
end
function c90001128.handcon(e)
	return Duel.IsExistingMatchingCard(c90001128.filter2,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
