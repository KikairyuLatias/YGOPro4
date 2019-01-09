--Itachi, Ninja Fur Hire
function c90000503.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000503,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000503.spcon)
	c:RegisterEffect(e1)
	--banish when Fur Hires comes out
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000503,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,90000503)
	e2:SetCondition(c90000503.hdcon)
	e2:SetTarget(c90000503.hdtg)
	e2:SetOperation(c90000503.hdop)
	c:RegisterEffect(e2)
end

--ss
function c90000503.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0,nil)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end

--banish for Fur Hire
function c90000503.hdfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x114)
end
function c90000503.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c90000503.hdfilter,1,nil,tp)
end
function c90000503.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000503.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c90000503.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
