--ＺＰＤ中央本部
function c90000105.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000105.tg)
	e2:SetValue(c90000105.val)
	c:RegisterEffect(e2)
	--def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(c90000105.val)
	e3:SetTarget(c90000105.tg)
	c:RegisterEffect(e3)
	--special summoning
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c90000105.target)
	e4:SetOperation(c90000105.activate)
	c:RegisterEffect(e4)
	--opponent can't trigger
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(c90000105.actcon)
	e5:SetOperation(c90000105.actop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e6)
end

--boost
function c90000105.tg(e,c)
	return c:IsSetCard(0x4b0) and c:IsType(TYPE_MONSTER)
end
function c90000105.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b0)
end
function c90000105.val(e,c)
	return Duel.GetMatchingGroupCount(c90000105.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
--ss condition
function c90000105.filter2(c)
	return c:IsSetCard(0x4b0) and c:IsType(TYPE_MONSTER) and c:GetLevel()<=4
end
function c90000105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000105.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c90000105.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90000105.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
--forget about triggering
function c90000105.actcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsControler(tp) and tc:IsSetCard(0x4b0)
end
function c90000105.actop(e,tp,eg,ep,ev,re,r,rp)
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetTargetRange(0,1)
	e5:SetValue(c90000105.aclimit)
	e5:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e5,tp)
end
function c90000105.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end

