--Spirit Jewel of the Psychic Dragon - Soul Dew
function c90000231.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c90000231.target)
	e1:SetOperation(c90000231.operation)
	c:RegisterEffect(e1)
	--ATK up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--DEF up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(1000)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c90000231.eqlimit)
	c:RegisterEffect(e4)
	--destroy sub
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetTarget(c90000231.reptg)
	e5:SetOperation(c90000231.repop)
	c:RegisterEffect(e5)
	--lp gain when it destroys stuff
end

--equip limitation (not like Soul Dew does anything for rest of them)
function c90000231.eqlimit(e,c)
	return c:IsCode(90000251,90000252)
end
function c90000231.filter(c)
	return c:IsFaceup() and c:IsCode(90000251,90000252)
end
function c90000231.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c90000231.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000231.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c90000231.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c90000231.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end

--use as protection
function c90000231.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return Duel.SelectYesNo(tp,aux.Stringid(90000231,1))
end
function c90000231.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
