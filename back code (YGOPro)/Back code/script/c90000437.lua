--Dreamlight Awakening
function c90000437.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000437,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,90000437)
	e2:SetCondition(c90000437.drcon)
	e2:SetTarget(c90000437.drtg)
	e2:SetOperation(c90000437.drop)
	c:RegisterEffect(e2)
	--counter thing
	if c90000437.counter==nil then
		c90000437.counter=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c90000437.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c90000437.clearop)
		Duel.RegisterEffect(ge2,0)
	end
end
--counter for draw stuff
function c90000437.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsPreviousLocation(LOCATION_ONFIELD) and tc:IsSetCard(0x5f7) or tc:IsSetCard(0x5f8) then
			local typ=bit.band(tc:IsSetCard,0x5f7)
			if (typ==TYPE_MONSTER and Duel.GetFlagEffect(0,90000437)==0)
				then
				c90000437.counter=c90000437.counter+1
				if typ==TYPE_MONSTER then
					Duel.RegisterFlagEffect(0,90000437,RESET_PHASE+PHASE_END,0,1)
			end
		tc=eg:GetNext()
	end
end
function c90000437.clearop(e,tp,eg,ep,ev,re,r,rp)
	c90000437.counter=0
end

--draw stuff
function c90000437.drcon(e,tp,eg,ep,ev,re,r,rp)
	return c90000437.counter>0
end
function c90000437.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,c90000437.counter) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,c90000437.counter)
end
function c90000437.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Draw(tp,c90000437.counter,REASON_EFFECT)
end