--Sakura the Jōnin Snowstorm Reindeer Ninja
function c90001262.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.FilterBoolFunction(Card.IsCode,90001260),1,1)
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
		e2:SetValue(c90001262.indval)
		c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90001262,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c90001262.target)
	e3:SetOperation(c90001262.activate)
	c:RegisterEffect(e3)
	--the power of ZPD banish authority, so lock on and shoot
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90001262,1))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90001262.target2)
	e4:SetOperation(c90001262.operation2)
	c:RegisterEffect(e4)
end

--immunity
function c90001262.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--special summon
function c90001262.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9d0) 
end
function c90001262.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90001262.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c90001262.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90001262.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

-- lock and fire
function c90001262.lmfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9d0) and not c:IsCode(90001262)
end

function c90001262.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,nil) end 
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	if Duel.IsExistingMatchingCard(c90001262.lmfilter,tp,LOCATION_MZONE,0,1,nil) and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			Duel.SetChainLimit(c90001262.chainlm)
		end
end

function c90001262.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,1,nil)
	e:GetHandler():RegisterFlagEffect(90001262,RESET_EVENT+0x1fe0000,0,1)
	Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
end

function c90001262.chainlm(e,rp,tp)
	return tp==rp
end
--protection value
function c90001262.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end