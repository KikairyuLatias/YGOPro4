--Diver Deer Anseulium
local s,id=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.sprcon)
	e1:SetOperation(s.sprop)
	e1:SetCountLimit(1,id)
	c:RegisterEffect(e1)
	--protection effects
end

--ss condition
function s.sprfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af) and c:IsAbleToDeckOrExtraAsCost()
end

function s.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.sprfilter,tp,LOCATION_FIELD,0,2,nil)
end

function s.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,s.sprfilter,tp,LOCATION_FIELD,0,2,2,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
