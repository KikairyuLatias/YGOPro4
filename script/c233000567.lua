--Diver Equine Hazard Preparation
local s,id=GetID()
function s.initial_effect(c)
	--Ritual Summon
	Ritual.AddProcEqual(c,s.ritualfil,nil,nil,s.extrafil,nil,nil,nil,LOCATION_HAND|LOCATION_DECK|LOCATION_EXTRA):SetCountLimit(1,id)
	--Add itself to hand
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

s.listed_series={0x4af}

--ritual summon
function s.ritualfil(c)
	return c:IsSetCard(0x4af) and c:IsRace(RACE_BEASTWARRIOR) and c:IsRitualMonster()
end

function s.mfilter(c)
	return c:HasLevel() and c:IsSetCard(0x4af) 
		and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function s.extrafil(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_EXTRA,0,nil)
end

--add back to hand
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