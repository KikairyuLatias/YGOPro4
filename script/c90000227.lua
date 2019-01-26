--Psychic Dragon Mangetsu
function c90000227.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000227,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90000227.spcon)
	e1:SetOperation(c90000227.spop)
	c:RegisterEffect(e1)
	--buff by 400
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(0,LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c90000227.dcon)
	e2:SetOperation(c90000227.dop)
	c:RegisterEffect(e2)
end
--ss cost
function c90000227.filter(c)
	return c:IsSetCard(0x5f1) and c:IsAbleToRemoveAsCost()
end
function c90000227.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000227.filter,c:GetControler(),LOCATION_HAND,0,3,nil)
end
function c90000227.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c90000227.filter,tp,LOCATION_HAND,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end

--damage + 400
function c90000227.dcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget()==nil then return false end
	return eg:GetFirst():IsSetCard(0x5f1)
end
function c90000227.dcon2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget()==nil then return false end
	return eg:GetFirst():IsSetCard(0x5f1)
end
function c90000227.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev+400)
end