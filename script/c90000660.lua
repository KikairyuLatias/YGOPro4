-- Superscuba Pony Zealot Diver
function c90000660.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x439),1,1,aux.NonTuner(Card.IsSetCard,0x2439),1,99)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--protection
		--cannot target
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetValue(aux.tgoval)
		c:RegisterEffect(e1)
	--multiple attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000660,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c90000660.mtcon)
	e2:SetOperation(c90000660.mtop)
	c:RegisterEffect(e2)
	--become a scale
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000660,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c90000660.pencon)
	e3:SetTarget(c90000660.pentg)
	e3:SetOperation(c90000660.penop)
	c:RegisterEffect(e3)
	--special summon (modify to send from Deck)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000660,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1,90000660)
	e4:SetCost(c90000660.spcost)
	e4:SetTarget(c90000660.sptg)
	e4:SetOperation(c90000660.spop)
	c:RegisterEffect(e4)
end

--to pendulumZ
function c90000660.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return r&REASON_EFFECT+REASON_BATTLE~=0 and c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c90000660.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c90000660.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
--can't target me bois
function c90000660.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--ssd
function c90000660.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
end
function c90000660.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.ConfirmDecktop(tp,2)
	local g=Duel.GetDecktopGroup(tp,2)
	local ct=g:FilterCount(Card.IsSetCard,nil,0x2439)
	Duel.ShuffleDeck(tp)
	if ct>1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(ct)
		c:RegisterEffect(e1)
	end
end

--special summon
function c90000660.cfilter1(c)
	return c:IsLocation(LOCATION_DECK) and c:IsSetCard(0x439) and c:IsAbleToGraveAsCost()
end
function c90000660.cfilter2(c)
	return c:IsLocation(LOCATION_DECK) and c:IsSetCard(0x439) and c:IsAbleToGraveAsCost()
end
function c90000660.rescon(sg,e,tp,mg)
	return aux.ChkfMMZ(1)(sg,e,tp,mg) and sg:IsExists(c90000660.chk,1,nil,sg) and sg:CheckWithSumEqual(Card.GetLevel,10,2,2)
end
function c90000660.chk(c,sg)
	return c90000660.cfilter1(c) and sg:IsExists(c90000660.cfilter2,1,c)
end
function c90000660.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(c90000660.cfilter1,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c90000660.cfilter2,tp,LOCATION_MZONE,0,nil)
	local g=g1:Clone()
	g:Merge(g2)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and g1:GetCount()>0 and g2:GetCount()>0 
		and aux.SelectUnselectGroup(g,e,tp,2,2,c90000660.rescon,0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,2,2,c90000660.rescon,1,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c90000660.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90000660.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end