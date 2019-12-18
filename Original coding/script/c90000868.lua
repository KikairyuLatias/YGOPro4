--Phoenix Guardian - Double Wing
function c90000868.initial_effect(c)
	--second attack
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,90000868)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c90000868.target)
	e3:SetOperation(c90000868.operation)
	c:RegisterEffect(e3,false,1)
end
--dual strike
function c90000868.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x641) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c90000868.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c90000868.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000868.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c90000868.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c90000868.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end