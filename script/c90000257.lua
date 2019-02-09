--Psychic Dragon Sapphire
function c90000257.initial_effect(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c90000257.descon)
	e2:SetTarget(c90000257.destg)
	e2:SetOperation(c90000257.desop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
--stuff
function c90000257.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1)
end

function c90000257.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90000257.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c90000257.lmfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1) and c:IsAttackAbove(2300)
end
function c90000257.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	 if Duel.IsExistingMatchingCard(c90000257.lmfilter,tp,LOCATION_MZONE,0,1,nil) and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			Duel.SetChainLimit(c90000257.chainlm)
		end
end
function c90000257.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c90000257.cfilter,tp,LOCATION_MZONE,0,e:GetHandler())
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,ct,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c90000257.chainlm(e,rp,tp)
	return tp==rp
end