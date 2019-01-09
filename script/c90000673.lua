--Advanced Superstar Professional Equestrian Duelist Enríque
function c90000673.initial_effect(c)
	 --xyz summon
	aux.AddXyzProcedure(c,c90000673.mfilter,9,3,c90000673.ovfilter,aux.Stringid(90000673,0),3,c90000673.xyzop)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c90000673.atkval)
	c:RegisterEffect(e1)
	--armades
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000673,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1e0)
	e2:SetCost(c90000673.thcost)
	e2:SetTarget(c90000673.thtg)
	e2:SetOperation(c90000673.thop)
	c:RegisterEffect(e2,false,1)
	--protect from effects
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e3:SetValue(aux.tgoval)
		c:RegisterEffect(e3)
end
--can't target me bois
function c90000673.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--boost
function c90000673.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x439)
end
function c90000673.atkval(e,c)
	return Duel.GetMatchingGroupCount(c90000673.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end

--new condition
function c90000673.ovfilter(c,tp,xyzc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ,xyzc,SUMMON_TYPE_XYZ,tp) and (c:GetRank()==7 or c:GetRank()==8) and c:IsRace(RACE_BEAST,xyzc,SUMMON_TYPE_XYZ,tp)
end
function c90000673.xyzop(e,tp,chk,mc)
	if chk==0 then return mc:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	mc:RemoveOverlayCard(tp,1,1,REASON_COST)
	return true
end
function c90000673.mfilter(c,xyz,sumtype,tp)
	return c:IsRace(RACE_BEAST,xyz,sumtype,tp)
end

--shuffle into deck
function c90000673.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c90000673.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c90000673.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,nil,REASON_EFFECT)
	end
end