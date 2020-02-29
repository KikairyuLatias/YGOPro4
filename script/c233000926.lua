--March of the Brave Dragon
local s,id=GetID()
function s.initial_effect(c)
	aux.AddRitualProcGreater(c,s.ritualfil,nil,nil,s.extrafil,s.extraop,s.forcedgroup,nil,LOCATION_HAND+LOCATION_GRAVE):SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	--opponent can't trigger
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(s.actcon)
	e4:SetOperation(s.actop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e5)  
end
--ritual stuff
function s.ritualfil(c)
	return c:IsCode(233000925)
end
function s.exfilter0(c)
	return c:IsAbleToGrave()
end
function s.extrafil(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0) < Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE) then
		return Duel.GetMatchingGroup(s.exfilter0,tp,LOCATION_DECK,0,nil)
	end
	return Group.CreateGroup()
end
function s.extraop(mg,e,tp,eg,ep,ev,re,r,rp)
	local mat2=mg:Filter(Card.IsLocation,nil,LOCATION_DECK)
	mg:Sub(mat2)
	Duel.ReleaseRitualMaterial(mg)
	Duel.SendtoGrave(mat2,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
end
function s.forcedgroup(c,e,tp)
	return c:IsLocation(LOCATION_HAND+LOCATION_ONFIELD) or c:IsLocation(LOCATION_DECK)
end

--forget about triggering
function s.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) and c:IsRace(RACE_DRAGON) and c:GetBaseAttack()>=2500
end

function s.actcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsControler(tp) and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end

function s.actop(e,tp,eg,ep,ev,re,r,rp)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetTargetRange(0,1)
	e4:SetValue(s.aclimit)
	e4:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e4,tp)
end
function s.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end