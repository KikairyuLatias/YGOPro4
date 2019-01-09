--Skystorm Mecha Jet - Pink Impulse
function c90001004.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90001004,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetTarget(c90001004.destg)
	e1:SetOperation(c90001004.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--taking the bullet for comrades
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c90001004.reptg)
	e3:SetValue(c90001004.repval)
	e3:SetOperation(c90001004.repop)
	c:RegisterEffect(e3)
	--more bullets
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90001004,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c90001004.tgcon)
	e4:SetOperation(c90001004.tgop)
	c:RegisterEffect(e4)
end

--destroy on summon
function c90001004.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c90001004.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

--targeting redirect
function c90001004.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	local c=e:GetHandler()
	if tc==c or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsLocation(LOCATION_MZONE) or not (tc:IsRace(RACE_MACHINE) and tc:IsAttribute(ATTRIBUTE_WIND)) then return false end
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c)
end
function c90001004.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Group.CreateGroup()
		g:AddCard(c)
		Duel.ChangeTargetCard(ev,g)
	end
end

--destroy redirect
function c90001004.filter2(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_WIND) and not c:IsReason(REASON_REPLACE)
end
function c90001004.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c90001004.filter2,1,nil,tp) and not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(90001004,1))
end
function c90001004.repval(e,c)
	return c90001004.filter2(c,e:GetHandlerPlayer())
end
function c90001004.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end

