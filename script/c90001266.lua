--Snowstorm Reindeer Jutsu: Hidden Mist
function c90001266.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c90001266.target)
	e1:SetOperation(c90001266.activate)
	c:RegisterEffect(e1)
	--lock opponent from triggering backrow
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90001266,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c90001266.negcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c90001266.locktg)
	e2:SetOperation(c90001266.lockop)
	c:RegisterEffect(e2)
end

--protection [needs work]
function c90001266.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0)
end
function c90001266.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90001266.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c90001266.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c90001266.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c90001266.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetOwnerPlayer(tp)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c90001266.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end

--no backrow for you
function c90001266.cfilter(c)
	return c:IsSetCard(0x9d0) and c:IsFaceup()
end

function c90001266.negcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.exccon(e) and Duel.IsExistingMatchingCard(c90001266.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end

function c90001266.locktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(90001266,0),aux.Stringid(90001266,1))
	e:SetLabel(op)
	Duel.SetTargetPlayer(1-tp)
end
function c90001266.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if e:GetLabel()==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetTargetRange(1,0)
		e1:SetValue(c90001266.aclimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,p)
	end
end
function c90001266.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel() and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c90001266.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end