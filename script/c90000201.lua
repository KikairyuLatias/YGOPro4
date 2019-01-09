-- Psychic Dragon Arashi
function c90000201.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000201.spcon)
	c:RegisterEffect(e1)
	--summon restriction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c90000201.synlimit)
	c:RegisterEffect(e2)
	--lv change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000201,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c90000201.target)
	e3:SetOperation(c90000201.operation)
	c:RegisterEffect(e3)
end

--ss
function c90000201.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1) and not c:IsCode(90000201)
end
function c90000201.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000201.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

--limiter
function c90000201.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_DRAGON)
end

--level mod
function c90000201.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x5f1) and c:IsLevelAbove(1)
end
function c90000201.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c90000201.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90000201.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c90000201.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	local op=0
	if tc:GetLevel()==1 then op=Duel.SelectOption(tp,aux.Stringid(90000201,1))
	else op=Duel.SelectOption(tp,aux.Stringid(90000201,1),aux.Stringid(90000201,2)) end
	e:SetLabel(op)
end
function c90000201.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		if e:GetLabel()==0 then
			e1:SetValue(1)
		else e1:SetValue(-1) end
		tc:RegisterEffect(e1)
	end
end
