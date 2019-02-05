--Dreamlight Speedstar
function c90000407.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000407.spcon)
	c:RegisterEffect(e1)
	--synchro level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_LEVEL)
	e2:SetValue(c90000407.slevel)
	c:RegisterEffect(e2)
end

--ss
function c90000407.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x5f7) or c:IsSetCard(0x5f8)) and c:GetCode()~=90000407
end

function c90000407.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c90000407.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

--level 4
function c90000407.slevel(e,c)
	local lv=e:GetHandler():GetLevel()
	return 4*65536+lv or 2*65536+lv
end

--level 2
function c90000407.slevel2(e,c)
	local lv=e:GetHandler():GetLevel()
	return 2*65536+lv
end