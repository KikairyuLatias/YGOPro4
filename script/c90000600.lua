--Superstar Professional Equestrian Rider Enríque FX
function c90000600.initial_effect(c)
	--summon conditions
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_EFFECT),3,5,c90000600.lcheck)
	--protection
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetRange(LOCATION_MZONE)
	e0:SetTargetRange(0,LOCATION_MZONE)
	e0:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e0:SetValue(c90000600.atlimit)
	c:RegisterEffect(e0) 
	--banish stuff
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000600,1))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c90000600.thtg)
	e1:SetOperation(c90000600.thop)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c90000600.indval)
	c:RegisterEffect(e3)
	--stat bonus
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c90000600.atkval)
	c:RegisterEffect(e4)
end
--summon condition
function c90000600.lcheck(g,lc,tp)
	return g:IsExists(Card.IsRace,1,nil,RACE_BEAST)
end

--so advanced it is not funny
function c90000600.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--protection from attack
function c90000600.atlimit(e,c)
	return c~=e:GetHandler()
end

--banish forever
function c90000600.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_ONFIELD,LOCATION_GRAVE+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_ONFIELD,LOCATION_GRAVE+LOCATION_GRAVE,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c90000600.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	end
end

--stat value
function c90000600.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c90000600.atkval(e,c)
	return Duel.GetMatchingGroupCount(c90000600.cfilter,0,LOCATION_MZONE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_GRAVE,nil)*300
end