--Defender Moon Unicorn
function c90000685.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000685,0))
	e1:SetCategory(CATEGORY_LVCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c90000685.lvtg)
	e1:SetOperation(c90000685.lvop)
	c:RegisterEffect(e1)
end

function c90000685.filter(c)
	return c:IsFaceup() and not c:IsType(TYPE_XYZ)
end
function c90000685.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c90000685.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000685.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c90000685.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c90000685.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
