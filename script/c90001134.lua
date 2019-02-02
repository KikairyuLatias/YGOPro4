--Diver Deer Ancolie
function c90001134.initial_effect(c)
	--added normal summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x4af))
	c:RegisterEffect(e1)
	--lp gain
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90001134,0))
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c90001134.target)
	e2:SetOperation(c90001134.operation)
	c:RegisterEffect(e2)
end
--gain LP
function c90001134.recfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4af)
end
function c90001134.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c90001134.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct*300)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*300)
end
function c90001134.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c90001134.filter,tp,LOCATION_MZONE,0,nil)
	Duel.Recover(tp,ct*300,REASON_EFFECT)
end