--Phoenix Guardian - Defender Kouka
function c90000866.initial_effect(c)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000866,0))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c90000866.reptg)
	e2:SetValue(c90000866.repval)
	e2:SetOperation(c90000866.repop)
	c:RegisterEffect(e2)
end
--replacement
function c90000866.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0x641) and not c:IsReason(REASON_REPLACE)
end
function c90000866.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c90000866.filter,1,nil,tp) and eg:IsReason(REASON_EFFECT) and not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(90000866,1))
end
function c90000866.repval(e,c)
	return c90000866.filter(c,e:GetHandlerPlayer())
end
function c90000866.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end