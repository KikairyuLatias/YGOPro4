--Flare Bunny Cinnamon  
function c90000712.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	---disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c90000712.disable)
	e1:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e1)
	--rest of cinnamon's stuff goes here
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000712,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c90000712.cost)
	e2:SetOperation(c90000712.operation)
	c:RegisterEffect(e2)
	--come back
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000712,0))
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetTarget(c90000712.destg)
	e3:SetOperation(c90000712.desop)
	c:RegisterEffect(e3)
end
--negate your stuff
function c90000712.disable(e,c)
	return c:GetAttack()>=e:GetHandler():GetAttack() and (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT)
end

--boost
function c90000712.cfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c90000712.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000712.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c90000712.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c90000712.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

--vengeance is sweet
function c90000712.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c90000712.filter,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*800)
	end
end

function c90000712.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c90000712.filter,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,2,nil)
		Duel.Destroy(sg,REASON_EFFECT)
		local sg=Duel.GetOperatedGroup()
		if sg:GetCount()>0 then
		Duel.Damage(1-tp,sg:GetCount()*800,REASON_EFFECT)
		end
	end
end