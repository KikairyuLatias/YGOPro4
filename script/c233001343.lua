--Advent of the Flash Blossom Reindeer
local s,id=GetID()
function s.initial_effect(c)
	aux.AddRitualProcGreater(c,s.ritualfil,nil,nil,s.extrafil,s.extraop,s.forcedgroup,nil,LOCATION_HAND+LOCATION_GRAVE):SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.condition2)
	e2:SetTarget(s.target2)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
--ritual summon
function s.ritualfil(c)
	return c:IsSetCard(0x4c8) and c:IsRitualMonster()
end
function s.exfilter0(c)
	return c:IsSetCard(0x4c8) and c:GetLevel()>=1 and c:IsAbleToGrave()
end
function s.extrafil(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=0 then
		return Duel.GetMatchingGroup(s.exfilter0,tp,LOCATION_EXTRA+LOCATION_DECK,0,nil)
	end
	return Group.CreateGroup()
end
function s.extraop(mg,e,tp,eg,ep,ev,re,r,rp)
	local mat2=mg:Filter(Card.IsLocation,nil,LOCATION_EXTRA+LOCATION_DECK)
	mg:Sub(mat2)
	Duel.ReleaseRitualMaterial(mg)
	Duel.SendtoGrave(mat2,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
end
function s.forcedgroup(c,e,tp)
	return (c:IsSetCard(0x4c8) and c:IsLocation(LOCATION_HAND+LOCATION_ONFIELD)) or (c:IsSetCard(0x4c8) and c:IsLocation(LOCATION_EXTRA+LOCATION_DECK))
end

--come back to hand
function s.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end