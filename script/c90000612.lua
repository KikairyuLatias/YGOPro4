--Superstar Pony American Blitz
function c90000612.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x439),8,2)
	c:EnableReviveLimit()
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(0,LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c90000612.dcon)
	e1:SetOperation(c90000612.dop)
	c:RegisterEffect(e1)
	--cannot be targeted by card effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(aux.tgoval)
	e2:SetCondition(c90000612.dscon)
	c:RegisterEffect(e2)
	--destroy shit
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000612,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c90000612.descost)
	e3:SetTarget(c90000612.destg)
	e3:SetOperation(c90000612.desop)
	c:RegisterEffect(e3)
	--pendulum
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c90000612.pencon)
	e4:SetTarget(c90000612.pentg)
	e4:SetOperation(c90000612.penop)
	c:RegisterEffect(e4)
	--Pendulum effects
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD)
		e5:SetCode(EFFECT_UPDATE_ATTACK)
		e5:SetRange(LOCATION_PZONE)
		e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e5:SetTarget(c90000612.tg)
		e5:SetValue(800)
		c:RegisterEffect(e5)
		local e6=e5:Clone()
		e6:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e6)
		--spsummon
		local e8=Effect.CreateEffect(c)
		e8:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
		e8:SetType(EFFECT_TYPE_IGNITION)
		e8:SetRange(LOCATION_PZONE)
		e8:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e8:SetTarget(c90000612.sptg)
		e8:SetOperation(c90000612.spop)
		c:RegisterEffect(e8)
end

--2x damage
function c90000612.dcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsSetCard(0x439) and tc:GetBattleTarget()~=nil
end
function c90000612.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end

-- protecting my ass, boi
function c90000612.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

function c90000612.dscon(e)
	return e:GetHandler():GetOverlayCount()~=0
end

--destruction for horses
function c90000612.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c90000612.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c90000612.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

--Become a Scale
function c90000612.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c90000612.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_PZONE,0)>0 end
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c90000612.penop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	if Duel.Destroy(g,REASON_EFFECT)~=0 and e:GetHandler():IsRelateToEffect(e) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end

--stat boosting
function c90000612.tg(e,c)
	return (c:IsSetCard(0x439) or c:IsSetCard(0x1439))
end

--summon self
function c90000612.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x439)
end
function c90000612.desfilter2(c,e)
	return c90000612.desfilter(c) and c:IsCanBeEffectTarget(e)
end
function c90000612.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c90000612.desfilter(chkc) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c90000612.desfilter2,tp,LOCATION_ONFIELD,0,nil,e)
	if chk==0 then return ft>-3 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and g:GetCount()>2 and aux.SelectUnselectGroup(g,e,tp,3,3,aux.ChkfMMZ(1),0) end
	local sg=aux.SelectUnselectGroup(g,e,tp,3,3,aux.ChkfMMZ(1),1,tp,HINTMSG_DESTROY)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90000612.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end