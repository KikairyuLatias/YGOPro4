--Hazmat Diver Equine Kyokugen
local s,id=GetID()
function s.initial_effect(c)
	--pendulum summon
	Pendulum.AddProcedure(c)
	c:EnableReviveLimit()
	--selfdes
	local e0a=Effect.CreateEffect(c)
	e0a:SetType(EFFECT_TYPE_SINGLE)
	e0a:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0a:SetCode(EFFECT_SELF_DESTROY)
	e0a:SetRange(LOCATION_PZONE)
	e0a:SetCondition(s.despcon)
	c:RegisterEffect(e0a)
	--negate for days
	local e1a=Effect.CreateEffect(c)
	e1a:SetType(EFFECT_TYPE_FIELD)
	e1a:SetCode(EFFECT_DISABLE)
	e1a:SetRange(LOCATION_PZONE)
	e1a:SetTargetRange(0,LOCATION_ONFIELD)
	c:RegisterEffect(e1a)
	--disable effect
	local e2a=Effect.CreateEffect(c)
	e2a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2a:SetCode(EVENT_CHAIN_SOLVING)
	e2a:SetRange(LOCATION_PZONE)
	e2a:SetOperation(s.disop)
	c:RegisterEffect(e2a)
	--special summon self from P-Zone by Tributing
	local e3a=Effect.CreateEffect(c)
	e3a:SetDescription(aux.Stringid(id,0))
	e3a:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3a:SetType(EFFECT_TYPE_IGNITION)
	e3a:SetRange(LOCATION_PZONE)
	e3a:SetCountLimit(1,id)
	e3a:SetCost(s.spcost)
	e3a:SetTarget(s.sptg)
	e3a:SetOperation(s.spop)
	c:RegisterEffect(e3a)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.immcon)
	e1:SetValue(s.efilter)
	c:RegisterEffect(e1)
	--no damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(s.damval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e3)
	--cannot release
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UNRELEASABLE_SUM)
	e4:SetCondition(s.immcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e5)
	--remove EVERYTHING
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(id,1))
	e6:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1,id)
	e6:SetCost(s.sgcost)
	e6:SetTarget(s.sgtg)
	e6:SetOperation(s.sgop)
	c:RegisterEffect(e6)
	--pendulum
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id,2))
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_DESTROYED)
	e7:SetProperty(EFFECT_FLAG_DELAY)
	e7:SetCondition(s.pencon)
	e7:SetTarget(s.pentg)
	e7:SetOperation(s.penop)
	c:RegisterEffect(e7)
end

--you can't cheese this out by using itself or another equivalent (you can go over though...)
function s.mat_filter(c)
	return c:GetLevel()~=12
end

--this is the workaround to not being able to restrict this from setting self in scale without ritual summoning
function s.despcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,e:GetHandler(),0x4af)
end

--i like to negate you hard
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if rp~=tp and (tl==LOCATION_MZONE or tl==LOCATION_SZONE) then
		Duel.NegateEffect(ev)
	end
end

--get out of the P-Zone
function s.cfilter(c)
	return c:IsSetCard(0x24af) and c:IsType(TYPE_MONSTER) and c:IsReleasable() and aux.SpElimFilter(c,true)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_MZONE,0,3,3,nil)
	Duel.Release(g,POS_FACEUP,REASON_COST)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

--immune to backrow
function s.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end

function s.immcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end

--this is here to block biodomain, okay?
function s.damval(e,re,val,r,rp,rc)
	if r&REASON_EFFECT~=0 then return 0 end
	return val
end

--chaos emperor dragon everything
function s.destfilter(c)
	return c:IsSetCard(0x4af) and c:IsType(TYPE_MONSTER) and c:IsRace(RACE_BEASTWARRIOR)
end
function s.lmfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x24af)
end

function s.sgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function s.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,0,0xe)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,#g*400)
	if Duel.IsExistingMatchingCard(s.lmfilter,tp,LOCATION_MZONE,0,1,nil) then
			Duel.SetChainLimit(s.chainlm)
		end
end

function s.chainlm(e,rp,tp)
	return tp==ep
end
function s.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,0xe)
	Duel.SendtoGrave(g,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
	Duel.BreakEffect()
	Duel.Damage(1-tp,ct*400,REASON_EFFECT)
end

--to pendulumZ
function s.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function s.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function s.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end