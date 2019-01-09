--Midnight Bunny
function c90000724.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,90000724)
	e1:SetCondition(c90000724.spcon)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c90000724.val)
	c:RegisterEffect(e2)
	--def down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c90000724.val2)
	c:RegisterEffect(e2)
end
function c90000724.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x7D0)
end
function c90000724.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000724.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c90000724.val(e,c)
	return c:GetLevel()*-100 or c:GetRank()*-100
end
function c90000724.val2(e,c)
	return c:GetLevel()*-100 or c:GetRank()*-100
end
