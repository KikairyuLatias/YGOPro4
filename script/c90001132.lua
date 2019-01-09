--Diver Deer Champion Xīfānlián
function c90001132.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,3,99,c90001132.lcheck)
	c:EnableReviveLimit()
	--mill your deck bro
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90001132,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c90001132.condition)
	e1:SetTarget(c90001132.target)
	e1:SetOperation(c90001132.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90001132,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c90001132.sumcon)
	e2:SetCost(c90001132.sumcost)
	e2:SetTarget(c90001132.sumtg)
	e2:SetOperation(c90001132.sumop)
	c:RegisterEffect(e2)
	--majespecter clause
		--cannot target
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e3:SetValue(aux.tgoval)
		c:RegisterEffect(e3)
		--indes
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e4:SetRange(LOCATION_MZONE)
		e4:SetValue(c90001132.indval)
		c:RegisterEffect(e4)
end

--link reqs
function c90001132.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end

-- protections
function c90001132.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--deck mill
function c90001132.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c90001132.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,3)
end
function c90001132.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end

--pay to revive
function c90001132.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c90001132.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c90001132.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90001132.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
